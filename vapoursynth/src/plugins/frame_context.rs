use std::marker::PhantomData;
use vapoursynth_sys as ffi;

use api::API;

/// A frame context used in filters.
#[derive(Debug, Clone, Copy)]
pub struct FrameContext<'a> {
    handle: *mut ffi::VSFrameContext,
    _owner: PhantomData<&'a ()>,
}

impl<'a> FrameContext<'a> {
    /// Wraps `handle` in a `FrameContext`.
    ///
    /// # Safety
    /// The caller must ensure `handle` is valid and API is cached.
    #[inline]
    pub(crate) unsafe fn from_ptr(handle: *mut ffi::VSFrameContext) -> Self {
        Self {
            handle,
            _owner: PhantomData,
        }
    }

    /// Returns the underlying pointer.
    #[inline]
    pub(crate) fn ptr(self) -> *mut ffi::VSFrameContext {
        self.handle
    }

    /// Returns the index of the node from which the frame is being requested.
    #[inline]
    pub fn output_index(self) -> usize {
        let index = unsafe { API::get_cached().get_output_index(self.handle) };
        debug_assert!(index >= 0);
        index as _
    }
}
