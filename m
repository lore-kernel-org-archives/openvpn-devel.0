From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Mar 2026 13:54:01 +0000
References: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9056e60d98f8210797a3e5a8520389ef06b214a8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YNoDRP2CEbE="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: doc: add Doxygen
 documentation to buffer.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YNoDRP2CEbE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1581?usp=3Demail

to review the following change.


Change subject: doc: add Doxygen documentation to buffer.h
......................................................................

doc: add Doxygen documentation to buffer.h

Document all previously undocumented elements.

Github: Fixes #864
Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.h
1 file changed, 1,032 insertions(+), 63 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1581/1

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 040f752..87d7d80 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -20,12 +20,22 @@
  *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

+/**
+ * @file
+ * @brief Buffer management functions and garbage collection.
+ *
+ * This module provides the core \c buffer type used throughout OpenVPN to
+ * hold packet data, as well as a simple memory management system
+ * (\c gc_arena / \c gc_malloc()) and various string/memory utility functi=
ons.
+ */
+
 #ifndef BUFFER_H
 #define BUFFER_H

 #include "basic.h"
 #include "error.h"

+/** Maximum allowed size (in bytes) for a single buffer allocation. */
 #define BUF_SIZE_MAX 1000000

 /*
@@ -114,36 +124,119 @@
  */
 struct gc_arena
 {
-    struct gc_entry *list; /**< First element of the linked list of
-                            *   \c gc_entry structures. */
-    struct gc_entry_special *list_special;
+    struct gc_entry *list;                 /**< First element of the linke=
d list of
+                                            *   \c gc_entry structures. */
+    struct gc_entry_special *list_special; /**< First element of the linked
+                                            *   list of \c gc_entry_special
+                                            *   structures for allocations
+                                            *   requiring a custom free
+                                            *   function. */
 };


+/** Return a pointer to the start of the buffer content. @see buf_bptr() */
 #define BPTR(buf)  (buf_bptr(buf))
+/** Return a pointer one past the end of the buffer content. @see buf_bend=
() */
 #define BEND(buf)  (buf_bend(buf))
+/** Return a pointer to the last byte of the buffer content, or NULL if em=
pty. @see buf_blast() */
 #define BLAST(buf) (buf_blast(buf))
+/** Return the length of the buffer content in bytes. @see buf_len() */
 #define BLEN(buf)  (buf_len(buf))
+/** Return the length of the buffer content as a \c size_t. @see buf_len()=
 */
 #define BLENZ(buf) ((size_t)buf_len(buf))
+/** Return true iff the buffer is defined (has non-NULL data pointer). @se=
e buf_defined() */
 #define BDEF(buf)  (buf_defined(buf))
+/** Return the buffer content pointer cast to \c char *. @see buf_str() */
 #define BSTR(buf)  (buf_str(buf))
+/** Return the number of bytes available for appending to the buffer. @see=
 buf_forward_capacity() */
 #define BCAP(buf)  (buf_forward_capacity(buf))

+/**
+ * Zeroise and reset a buffer.
+ *
+ * Sets all allocated memory to zero and resets \c offset and \c len to ze=
ro,
+ * but does not free the underlying memory.
+ *
+ * @param buf   The buffer to clear.
+ */
 void buf_clear(struct buffer *buf);
=20
+/**
+ * Free the memory allocated for a buffer.
+ *
+ * Frees \c buf->data and resets the buffer to an undefined state.
+ *
+ * @param buf   The buffer whose memory is to be freed.
+ */
 void free_buf(struct buffer *buf);

+/**
+ * Assign the content of one buffer to another.
+ *
+ * Copies the content of \c src into \c dest.  The destination buffer must
+ * already be allocated with sufficient capacity.
+ *
+ * @param dest  Destination buffer to write into.
+ * @param src   Source buffer to read from.
+ *
+ * @return true on success, false if \c dest has insufficient capacity.
+ */
 bool buf_assign(struct buffer *dest, const struct buffer *src);

+/**
+ * Securely clear a null-terminated string.
+ *
+ * Overwrites all characters of \c str with zeroes.
+ *
+ * @param str   The string to clear.
+ */
 void string_clear(char *str);

+/**
+ * Return the number of elements in a NULL-terminated array of strings.
+ *
+ * @param array     NULL-terminated array of string pointers.
+ *
+ * @return Number of non-NULL elements.
+ */
 int string_array_len(const char **array);

+/**
+ * Safely compute the product of two sizes plus an extra amount.
+ *
+ * Each of \c m1, \c m2, and \c extra, as well as the final result, are
+ * checked against \c ALLOC_SIZE_MAX.  If any value exceeds the limit the
+ * function calls \c msg(M_FATAL) and does not return.
+ *
+ * @param m1    First multiplicand.
+ * @param m2    Second multiplicand.
+ * @param extra Value to add to the product.
+ *
+ * @return \c m1 * \c m2 + \c extra.
+ */
 size_t array_mult_safe(const size_t m1, const size_t m2, const size_t extr=
a);

+/** Flag for print_argv(): wrap each argument in square brackets. */
 #define PA_BRACKET (1 << 0)
+/**
+ * Format a NULL-terminated argument vector as a single string.
+ *
+ * @param p     NULL-terminated array of string pointers to format.
+ * @param gc    Garbage collection arena for the returned string.
+ * @param flags Formatting flags (e.g. \c PA_BRACKET).
+ *
+ * @return Newly allocated string representation of \c p.
+ */
 char *print_argv(const char **p, struct gc_arena *gc, const unsigned int f=
lags);

+/**
+ * Report a buffer size error and abort.
+ *
+ * Called when a requested buffer size exceeds \c BUF_SIZE_MAX or is other=
wise
+ * invalid.  Calls \c msg(M_FATAL) and does not return.
+ *
+ * @param size  The invalid size that was requested.
+ */
 void buf_size_error(const size_t size);

 /* for dmalloc debugging */
@@ -157,36 +250,121 @@
 #define string_alloc(str, gc)         string_alloc_debug(str, gc, __FILE__=
, __LINE__)
 #define string_alloc_buf(str, gc)     string_alloc_buf_debug(str, gc, __FI=
LE__, __LINE__)

+/** Debug variant of \c alloc_buf() that records the allocation site. */
 struct buffer alloc_buf_debug(size_t size, const char *file, int line);

+/** Debug variant of \c alloc_buf_gc() that records the allocation site. */
 struct buffer alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const c=
har *file, int line);

+/** Debug variant of \c clone_buf() that records the allocation site. */
 struct buffer clone_buf_debug(const struct buffer *buf, const char *file, =
int line);

+/** Debug variant of \c gc_malloc() that records the allocation site. */
 void *gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const c=
har *file, int line);

+/** Debug variant of \c string_alloc() that records the allocation site. */
 char *string_alloc_debug(const char *str, struct gc_arena *gc, const char =
*file, int line);

+/** Debug variant of \c string_alloc_buf() that records the allocation sit=
e. */
 struct buffer string_alloc_buf_debug(const char *str, struct gc_arena *gc,=
 const char *file,
                                      int line);

 #else  /* ifdef DMALLOC */

+/**
+ * Allocate a buffer of the given size.
+ *
+ * Calls \c out_of_memory() if the allocation fails. The caller is respons=
ible
+ * for freeing the memory.
+ *
+ * @param size  Number of bytes to allocate.
+ *
+ * @return Newly allocated buffer of capacity \c size.
+ */
 struct buffer alloc_buf(size_t size);

-struct buffer alloc_buf_gc(size_t size,
-                           struct gc_arena *gc); /* allocate buffer with g=
arbage collection */
+/**
+ * Allocate a buffer of the given size under garbage collection.
+ *
+ * The allocated memory is registered with \c gc so that it is freed when
+ * \c gc_free() is called on the arena.  Calls \c out_of_memory() if the
+ * allocation fails.
+ *
+ * @param size  Number of bytes to allocate.
+ * @param gc    Garbage collection arena to register the allocation with.
+ *
+ * @return Newly allocated buffer of capacity \c size.
+ */
+struct buffer alloc_buf_gc(size_t size, struct gc_arena *gc);

+/**
+ * Duplicate a buffer, including its content.
+ *
+ * Allocates a new buffer with the same capacity as \c buf and copies its
+ * content.  Calls \c out_of_memory() if the allocation fails.
+ *
+ * @param buf   The buffer to duplicate.
+ *
+ * @return A newly allocated copy of \c buf.
+ */
 struct buffer clone_buf(const struct buffer *buf);

+/**
+ * Allocate memory and, optionally, zero it.
+ *
+ * The allocation is registered with \c a so that it is freed when
+ * \c gc_free() is called on the arena.  Calls \c out_of_memory() if the
+ * allocation fails.
+ *
+ * @param size  Number of bytes to allocate.
+ * @param clear If true, zeroise the allocated memory before returning.
+ * @param a     Garbage collection arena to register the allocation with.
+ *
+ * @return Pointer to the newly allocated memory.
+ */
 void *gc_malloc(size_t size, bool clear, struct gc_arena *a);

+/**
+ * Duplicate a string, allocating memory under garbage collection.
+ *
+ * @param str   The string to duplicate.  May be NULL, in which case NULL
+ *              is returned.
+ * @param gc    Garbage collection arena for the returned string, or NULL
+ *              to use plain \c malloc().
+ *
+ * @return A newly allocated copy of \c str, or NULL if \c str is NULL.
+ */
 char *string_alloc(const char *str, struct gc_arena *gc);

+/**
+ * Allocate a buffer containing a copy of the given string.
+ *
+ * Wraps \c string_alloc(), so \c gc may be NULL (plain \c malloc() is used
+ * in that case).  The buffer \c len reflects the string length, excluding
+ * the null terminator, even though the terminator is present in the
+ * allocated memory.
+ *
+ * @param str   The string to copy into the buffer.  Must not be NULL.
+ * @param gc    Garbage collection arena for the allocation, or NULL.
+ *
+ * @return A buffer whose content is a copy of \c str.
+ */
 struct buffer string_alloc_buf(const char *str, struct gc_arena *gc);

 #endif /* ifdef DMALLOC */

+/**
+ * Register an address with a custom free function in a garbage collection
+ * arena.
+ *
+ * When \c gc_free() is called on \c a, \c free_function(addr) will be
+ * invoked to release the memory.  Use this for allocations that require
+ * something other than plain \c free(), such as \c freeaddrinfo().
+ *
+ * @param addr          Pointer to the memory to register.
+ * @param free_function Function to call to free \c addr.
+ * @param a             Garbage collection arena to register with.
+ */
 void gc_addspecial(void *addr, void (*free_function)(void *), struct gc_ar=
ena *a);
=20
 /**
@@ -204,6 +382,7 @@

 #ifdef BUF_INIT_TRACKING
 #define buf_init(buf, offset) buf_init_debug(buf, offset, __FILE__, __LINE=
__)
+/** Debug variant of \c buf_init_dowork() that records the call site for a=
lignment verification. */
 bool buf_init_debug(struct buffer *buf, int offset, const char *file, int =
line);

 #else
@@ -212,31 +391,62 @@


 /* inline functions */
+
+/**
+ * Callback to free a \c struct \c addrinfo, suitable for use with
+ * \c gc_addspecial().
+ *
+ * @param addr  Pointer to the \c struct \c addrinfo to free.
+ */
 static inline void
 gc_freeaddrinfo_callback(void *addr)
 {
     freeaddrinfo((struct addrinfo *)addr);
 }

-/** Return an empty struct buffer */
+/** Return an empty, undefined \c struct \c buffer (all fields zero). */
 static inline struct buffer
 clear_buf(void)
 {
     return (struct buffer){ 0 };
 }

+/**
+ * Return true iff \c buf has a non-NULL data pointer.
+ *
+ * A defined buffer has been allocated but may have zero length or negative
+ * len (i.e. it is not necessarily valid).
+ *
+ * @param buf   The buffer to test.
+ */
 static inline bool
 buf_defined(const struct buffer *buf)
 {
     return buf->data !=3D NULL;
 }

+/**
+ * Return true iff \c buf is valid.
+ *
+ * A buffer is valid when its data pointer is non-NULL and its \c len is
+ * non-negative.
+ *
+ * @param buf   The buffer to test.
+ */
 static inline bool
 buf_valid(const struct buffer *buf)
 {
     return likely(buf->data !=3D NULL) && likely(buf->len >=3D 0);
 }

+/**
+ * Return a pointer to the start of the buffer content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Pointer to \c buf->data + \c buf->offset, or NULL if \c buf is
+ *         not valid.
+ */
 static inline uint8_t *
 buf_bptr(const struct buffer *buf)
 {
@@ -250,6 +460,13 @@
     }
 }

+/**
+ * Return the length of the buffer content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return \c buf->len if \c buf is valid, otherwise 0.
+ */
 static int
 buf_len(const struct buffer *buf)
 {
@@ -263,12 +480,27 @@
     }
 }

+/**
+ * Return a pointer one past the end of the buffer content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Pointer to the byte immediately after the last content byte.
+ */
 static inline uint8_t *
 buf_bend(const struct buffer *buf)
 {
     return buf_bptr(buf) + buf_len(buf);
 }

+/**
+ * Return a pointer to the last byte of the buffer content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Pointer to the last byte, or NULL if the buffer is empty or
+ *         invalid.
+ */
 static inline uint8_t *
 buf_blast(const struct buffer *buf)
 {
@@ -282,24 +514,56 @@
     }
 }

+/**
+ * Return true iff \c size is within the allowed buffer size range.
+ *
+ * @param size  The size to check.
+ *
+ * @return true if \c size < \c BUF_SIZE_MAX.
+ */
 static inline bool
 buf_size_valid(const size_t size)
 {
     return likely(size < BUF_SIZE_MAX);
 }

+/**
+ * Return true iff a signed \c size is within the allowed buffer size rang=
e.
+ *
+ * Accepts negative values (used for bidirectional length adjustments) as
+ * long as the absolute value is below \c BUF_SIZE_MAX.
+ *
+ * @param size  The signed size to check.
+ *
+ * @return true if \c -BUF_SIZE_MAX <=3D size < \c BUF_SIZE_MAX.
+ */
 static inline bool
 buf_size_valid_signed(const int size)
 {
     return likely(size >=3D -BUF_SIZE_MAX) && likely(size < BUF_SIZE_MAX);
 }

+/**
+ * Return the buffer content pointer cast to \c char *.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return The content pointer as a \c char *, or NULL if \c buf is invali=
d.
+ */
 static inline char *
 buf_str(const struct buffer *buf)
 {
     return (char *)buf_bptr(buf);
 }

+/**
+ * Reset a buffer to an undefined (unallocated) state.
+ *
+ * Sets all fields to zero/NULL without freeing any memory.  Use \c free_b=
uf()
+ * first if the buffer owns allocated memory.
+ *
+ * @param buf   The buffer to reset.
+ */
 static inline void
 buf_reset(struct buffer *buf)
 {
@@ -309,6 +573,14 @@
     buf->data =3D NULL;
 }

+/**
+ * Reset the length and offset of a buffer to zero.
+ *
+ * The underlying allocation is preserved and \c capacity is unchanged.
+ * Equivalent to rewinding the buffer to the beginning for fresh writing.
+ *
+ * @param buf   The buffer to reset.
+ */
 static inline void
 buf_reset_len(struct buffer *buf)
 {
@@ -316,6 +588,18 @@
     buf->offset =3D 0;
 }

+/**
+ * Initialise a buffer with a given initial offset.
+ *
+ * Sets \c buf->len to zero and \c buf->offset to \c offset.  The buffer m=
ust
+ * already be allocated.  Returns false (without modifying \c buf) if \c o=
ffset
+ * is negative, exceeds the buffer capacity, or the data pointer is NULL.
+ *
+ * @param buf     The buffer to initialise.
+ * @param offset  Initial byte offset from the start of the allocated memo=
ry.
+ *
+ * @return true on success, false if the parameters are invalid.
+ */
 static inline bool
 buf_init_dowork(struct buffer *buf, int offset)
 {
@@ -328,6 +612,17 @@
     return true;
 }

+/**
+ * Initialise a buffer with an externally provided writable memory region.
+ *
+ * Sets up \c buf to use \c data as its backing store for writing.  The fi=
rst
+ * byte of \c data is set to zero.  Calls \c buf_size_error() (which does =
not
+ * return) if \c size exceeds \c BUF_SIZE_MAX.
+ *
+ * @param buf   The buffer to initialise.
+ * @param data  Pointer to the memory region to use.
+ * @param size  Size of the memory region in bytes.
+ */
 static inline void
 buf_set_write(struct buffer *buf, uint8_t *data, int size)
 {
@@ -345,6 +640,18 @@
     }
 }

+/**
+ * Initialise a buffer with an externally provided read-only memory region.
+ *
+ * Sets up \c buf so that the entire \c data region is the buffer content
+ * (offset is 0, len and capacity are both set to \c size).  The data poin=
ter
+ * is cast away from const.  Calls \c buf_size_error() (which does not ret=
urn)
+ * if \c size exceeds \c BUF_SIZE_MAX.
+ *
+ * @param buf   The buffer to initialise.
+ * @param data  Pointer to the read-only memory region.
+ * @param size  Size of the memory region in bytes.
+ */
 static inline void
 buf_set_read(struct buffer *buf, const uint8_t *data, size_t size)
 {
@@ -357,7 +664,17 @@
     buf->data =3D (uint8_t *)data;
 }

-/* Like strncpy but makes sure dest is always null terminated */
+/**
+ * Like \c strncpy() but always null-terminates the destination.
+ *
+ * Copies at most \c maxlen - 1 characters from \c src into \c dest and
+ * writes a null terminator at \c dest[\c maxlen - 1].  Does nothing if
+ * \c maxlen is zero.
+ *
+ * @param dest    Destination buffer.
+ * @param src     Source string.
+ * @param maxlen  Size of the destination buffer in bytes.
+ */
 static inline void
 strncpynt(char *dest, const char *src, size_t maxlen)
 {
@@ -368,7 +685,13 @@
     }
 }

-/* return true if string contains at least one numerical digit */
+/**
+ * Return true if the string contains at least one decimal digit.
+ *
+ * @param src   The null-terminated string to scan.
+ *
+ * @return true if any character in \c src satisfies \c isdigit().
+ */
 static inline bool
 has_digit(const char *src)
 {
@@ -428,11 +751,20 @@
 #endif
 }

-/*
- * printf append to a buffer with overflow check,
- * due to usage of vsnprintf, it will leave space for
- * a final null character and thus use only
- * capacity - 1
+/**
+ * printf-style append to a buffer with overflow check.
+ *
+ * Formats a string and appends it to \c buf.  Due to the use of
+ * \c vsnprintf(), one byte of forward capacity is reserved for a null
+ * terminator, so at most \c buf_forward_capacity(buf) - 1 bytes of
+ * formatted output are written.
+ *
+ * @param buf     The buffer to append to.
+ * @param format  printf-style format string.
+ * @param ...     Format arguments.
+ *
+ * @return true if the entire formatted string fit in the buffer, false if
+ *         it was truncated.
  */
 bool buf_printf(struct buffer *buf, const char *format, ...)
 #ifdef __GNUC__
@@ -444,8 +776,13 @@
 #endif
     ;

-/*
- * puts append to a buffer with overflow check
+/**
+ * Append a string to a buffer with overflow check.
+ *
+ * @param buf   The buffer to append to.
+ * @param str   The null-terminated string to append.
+ *
+ * @return true if the string fit in the buffer, false if it was truncated.
  */
 bool buf_puts(struct buffer *buf, const char *str);

@@ -454,22 +791,76 @@
  * remove/add trailing characters
  */

+/**
+ * Force a null terminator at the end of the buffer content.
+ *
+ * If there is free capacity, a '\\0' byte is appended.  If the buffer is
+ * full, the last content byte is overwritten with '\\0' (i.e. the last
+ * character is truncated to make room).  The function has no effect on an
+ * empty or invalid buffer.
+ *
+ * @param buf   The buffer to null-terminate.
+ */
 void buf_null_terminate(struct buffer *buf);

+/**
+ * Remove trailing newline and carriage-return characters from a buffer.
+ *
+ * @param buf   The buffer to chomp.
+ */
 void buf_chomp(struct buffer *buf);

+/**
+ * Remove all occurrences of a specific byte from the end of a buffer.
+ *
+ * @param buf     The buffer to modify.
+ * @param remove  The byte value to strip from the tail.
+ */
 void buf_rmtail(struct buffer *buf, uint8_t remove);

-/*
- * non-buffer string functions
+/** @name String Utility Functions
+ *  @brief Non-buffer string functions
+ */
+/**@{*/
+
+/**
+ * Remove trailing newline and carriage-return characters from a string.
+ *
+ * @param str   The null-terminated string to chomp.
  */
 void chomp(char *str);

+/**
+ * Remove all trailing characters that appear in a given set.
+ *
+ * @param str             The null-terminated string to modify in place.
+ * @param what_to_delete  Null-terminated set of characters to strip.
+ */
 void rm_trailing_chars(char *str, const char *what_to_delete);

+/**
+ * Return a pointer past any leading whitespace in a string.
+ *
+ * @param str   The string to skip whitespace in.
+ *
+ * @return Pointer to the first non-whitespace character, or to the null
+ *         terminator if \c str is all whitespace.
+ */
 const char *skip_leading_whitespace(const char *str);

+/**
+ * Null-terminate a fixed-length string buffer.
+ *
+ * Ensures that \c str[\c len] is '\\0', clamping \c len to \c capacity - 1
+ * if necessary.
+ *
+ * @param str       The character buffer to null-terminate.
+ * @param len       Current string length.
+ * @param capacity  Total size of the character buffer in bytes.
+ */
 void string_null_terminate(char *str, int len, int capacity);
+/**@}*/
+/* End of string utility functions */

 /**
  * Write buffer contents to file.
@@ -481,40 +872,114 @@
  */
 bool buffer_write_file(const char *filename, const struct buffer *buf);

-/*
- * write a string to the end of a buffer that was
- * truncated by buf_printf
+/**
+ * Append a string to the physical end of a buffer that was truncated by
+ * \c buf_printf().
+ *
+ * If the buffer's forward capacity is one byte or less (i.e. it is full),
+ * \c str is written at the very end of the allocated memory to act as a
+ * truncation marker, provided it fits within the total buffer capacity.
+ * This is used to append a "[more...]" suffix after hex-dump truncation.
+ *
+ * @param buf   The buffer to append the truncation marker to.
+ * @param str   The null-terminated marker string to write.
  */
 void buf_catrunc(struct buffer *buf, const char *str);

-/*
- * Parse a string based on a given delimiter char
+/**
+ * Extract the next token from a buffer, delimited by a given character.
+ *
+ * Reads bytes from \c buf one at a time until \c delim or end-of-buffer is
+ * encountered.  The token (without the delimiter) is written into \c line,
+ * which is always null-terminated.  The delimiter byte is consumed from
+ * \c buf but not included in \c line.
+ *
+ * @param buf    Source buffer to parse.  The consumed portion is advanced.
+ * @param delim  Delimiter character.
+ * @param line   Output buffer for the extracted token.
+ * @param size   Size of \c line in bytes (must be > 0).
+ *
+ * @return false only when end-of-buffer is reached and no characters were
+ *         extracted; true otherwise (including when a delimiter was found
+ *         or \c line was truncated).
  */
 bool buf_parse(struct buffer *buf, const int delim, char *line, const int =
size);

-/*
- * Hex dump -- Output a binary buffer to a hex string and return it.
+/** @name Hex Dump
+ *  @brief Output a binary buffer to a hex string and return it.
  */
-#define FHE_SPACE_BREAK_MASK 0xFF  /* space_break parameter in lower 8 bit=
s */
-#define FHE_CAPS             0x100 /* output hex in caps */
+/**@{*/
+
+/** Mask for the space_break_flags field of \c format_hex_ex(): number of
+ *  bytes between separators (lower 8 bits). */
+#define FHE_SPACE_BREAK_MASK 0xFF
+/** Flag for \c format_hex_ex(): output hex digits in upper case. */
+#define FHE_CAPS             0x100
+/**
+ * Format a binary buffer as a hex string.
+ *
+ * @param data              Pointer to the binary data to format.
+ * @param size              Number of bytes to format.
+ * @param maxoutput         Maximum number of output characters (0 =3D unl=
imited).
+ *                          If the output is truncated, a "[more...]" suff=
ix is
+ *                          appended via \c buf_catrunc().
+ * @param space_break_flags Lower 8 bits (\c FHE_SPACE_BREAK_MASK) give the
+ *                          number of bytes between \c separator insertion=
s.
+ *                          Use \c FHE_CAPS to output upper-case hex digit=
s.
+ * @param separator         String to insert between groups of bytes.
+ * @param gc                Garbage collection arena for the returned stri=
ng.
+ *
+ * @return Null-terminated hex string allocated from \c gc.
+ */
 char *format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, un=
signed int space_break_flags,
                     const char *separator, struct gc_arena *gc);

+/**
+ * Format a binary buffer as a hex string with spaces every 4 bytes.
+ *
+ * Convenience wrapper around \c format_hex_ex().
+ *
+ * @param data       Pointer to the binary data to format.
+ * @param size       Number of bytes to format.
+ * @param maxoutput  Maximum number of output characters (0 =3D unlimited).
+ * @param gc         Garbage collection arena for the returned string.
+ *
+ * @return Null-terminated hex string allocated from \c gc.
+ */
 static inline char *
 format_hex(const uint8_t *data, size_t size, size_t maxoutput, struct gc_a=
rena *gc)
 {
     return format_hex_ex(data, size, maxoutput, 4, " ", gc);
 }
+/**@}*/
+/* End of Hex Dump */

-/*
- * Return a buffer that is a subset of another buffer.
+/**
+ * Return a sub-buffer of another buffer.
+ *
+ * Either allocates \c size bytes from the front or back of \c buf,
+ * shrinking \c buf accordingly, and returns a buffer pointing into the
+ * same memory.
+ *
+ * @param buf      Source buffer to carve the sub-buffer from.
+ * @param size     Number of bytes to include in the sub-buffer.
+ * @param prepend  If true, take bytes from the front of \c buf (prepend
+ *                 space); if false, take bytes from the end (append space=
).
+ *
+ * @return A buffer referencing the allocated region, or an undefined buff=
er
+ *         if \c buf has insufficient capacity.
  */
 struct buffer buf_sub(struct buffer *buf, int size, bool prepend);

-/*
- * Check if sufficient space to append to buffer.
+/**
+ * Check whether \c len bytes can be appended to a buffer.
+ *
+ * @param buf   The buffer to check.
+ * @param len   Number of bytes to append.
+ *
+ * @return true if \c buf is valid, \c len is within the allowed range, and
+ *         there is sufficient capacity after the current content.
  */
-
 static inline bool
 buf_safe(const struct buffer *buf, size_t len)
 {
@@ -522,6 +987,18 @@
            && buf->offset + buf->len + (int)len <=3D buf->capacity;
 }

+/**
+ * Check whether \c len bytes can be added to or removed from a buffer.
+ *
+ * Accepts negative \c len to verify that bytes can be removed (length
+ * decreased).
+ *
+ * @param buf   The buffer to check.
+ * @param len   Number of bytes to add (positive) or remove (negative).
+ *
+ * @return true if the resulting length would remain non-negative and with=
in
+ *         the allocated capacity.
+ */
 static inline bool
 buf_safe_bidir(const struct buffer *buf, int len)
 {
@@ -536,6 +1013,17 @@
     }
 }

+/**
+ * Return the number of bytes that can still be appended to the buffer.
+ *
+ * This is the space between the end of the current content and the end of
+ * the allocated memory.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Number of bytes available for appending, or 0 if \c buf is
+ *         invalid.
+ */
 static inline int
 buf_forward_capacity(const struct buffer *buf)
 {
@@ -554,6 +1042,17 @@
     }
 }

+/**
+ * Return the total number of bytes available from the current offset to t=
he
+ * end of the allocated memory.
+ *
+ * Unlike \c buf_forward_capacity(), this includes the bytes already occup=
ied
+ * by the current content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Capacity minus offset, or 0 if \c buf is invalid.
+ */
 static inline int
 buf_forward_capacity_total(const struct buffer *buf)
 {
@@ -572,6 +1071,16 @@
     }
 }

+/**
+ * Return the number of bytes available for prepending to the buffer.
+ *
+ * This is the number of bytes between the start of the allocated memory a=
nd
+ * the current content start (i.e. \c buf->offset).
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return \c buf->offset, or 0 if \c buf is invalid.
+ */
 static inline int
 buf_reverse_capacity(const struct buffer *buf)
 {
@@ -585,6 +1094,17 @@
     }
 }

+/**
+ * Increase or decrease the length of a buffer.
+ *
+ * Adjusts \c buf->len by \c inc bytes.  A negative \c inc shrinks the
+ * buffer.  The operation is bounds-checked via \c buf_safe_bidir().
+ *
+ * @param buf   The buffer to modify.
+ * @param inc   Number of bytes to add to the length (may be negative).
+ *
+ * @return true on success, false if the adjustment would violate bounds.
+ */
 static inline bool
 buf_inc_len(struct buffer *buf, int inc)
 {
@@ -596,11 +1116,18 @@
     return true;
 }

-/*
- * Make space to prepend to a buffer.
- * Return NULL if no space.
+/**
+ * Make space at the front of a buffer for prepending data.
+ *
+ * Moves the content start backwards by \c size bytes, increasing \c len
+ * and decreasing \c offset by the same amount.
+ *
+ * @param buf   The buffer to modify.
+ * @param size  Number of bytes to reserve for prepending.
+ *
+ * @return Pointer to the newly reserved space (new content start), or NULL
+ *         if \c buf is invalid or there is insufficient prepend capacity.
  */
-
 static inline uint8_t *
 buf_prepend(struct buffer *buf, ssize_t size)
 {
@@ -613,6 +1140,17 @@
     return BPTR(buf);
 }

+/**
+ * Advance the content start of a buffer, consuming bytes from the front.
+ *
+ * Increases \c offset and decreases \c len by \c size bytes.
+ *
+ * @param buf   The buffer to advance.
+ * @param size  Number of bytes to skip.
+ *
+ * @return true on success, false if \c buf is invalid or \c size exceeds
+ *         the current length.
+ */
 static inline bool
 buf_advance(struct buffer *buf, ssize_t size)
 {
@@ -625,11 +1163,18 @@
     return true;
 }

-/*
- * Return a pointer to allocated space inside a buffer.
- * Return NULL if no space.
+/**
+ * Reserve space at the end of a buffer for writing.
+ *
+ * Increases \c buf->len by \c size and returns a pointer to the start of
+ * the newly reserved region.
+ *
+ * @param buf   The buffer to allocate space in.
+ * @param size  Number of bytes to reserve.
+ *
+ * @return Pointer to the start of the reserved space, or NULL if there is
+ *         insufficient capacity.
  */
-
 static inline uint8_t *
 buf_write_alloc(struct buffer *buf, size_t size)
 {
@@ -643,6 +1188,18 @@
     return ret;
 }

+/**
+ * Consume bytes from the front of a buffer for reading.
+ *
+ * Returns a pointer to the current content start and advances the buffer
+ * by \c size bytes.
+ *
+ * @param buf   The buffer to read from.
+ * @param size  Number of bytes to consume.
+ *
+ * @return Pointer to the start of the consumed region, or NULL if \c size
+ *         is negative or exceeds the current length.
+ */
 static inline uint8_t *
 buf_read_alloc(struct buffer *buf, int size)
 {
@@ -657,6 +1214,17 @@
     return ret;
 }

+/**
+ * Append data to a buffer.
+ *
+ * Copies \c size bytes from \c src to the end of \c dest.
+ *
+ * @param dest  Destination buffer.
+ * @param src   Data to append.
+ * @param size  Number of bytes to append.
+ *
+ * @return true on success, false if there is insufficient capacity.
+ */
 static inline bool
 buf_write(struct buffer *dest, const void *src, size_t size)
 {
@@ -669,6 +1237,18 @@
     return true;
 }

+/**
+ * Prepend data to a buffer.
+ *
+ * Copies \c size bytes from \c src into the prepend space at the front of
+ * \c dest.
+ *
+ * @param dest  Destination buffer.
+ * @param src   Data to prepend.
+ * @param size  Number of bytes to prepend.
+ *
+ * @return true on success, false if there is insufficient prepend capacit=
y.
+ */
 static inline bool
 buf_write_prepend(struct buffer *dest, const void *src, int size)
 {
@@ -681,12 +1261,28 @@
     return true;
 }

+/**
+ * Append a uint8_t to a buffer.
+ *
+ * @param dest  Destination buffer.
+ * @param data  Byte to append.
+ *
+ * @return true on success, false if there is insufficient capacity.
+ */
 static inline bool
 buf_write_u8(struct buffer *dest, uint8_t data)
 {
     return buf_write(dest, &data, sizeof(uint8_t));
 }

+/**
+ * Append a uint16_t to a buffer in network byte order.
+ *
+ * @param dest  Destination buffer.
+ * @param data  Value to append (converted with \c htons()).
+ *
+ * @return true on success, false if there is insufficient capacity.
+ */
 static inline bool
 buf_write_u16(struct buffer *dest, uint16_t data)
 {
@@ -694,6 +1290,14 @@
     return buf_write(dest, &u16, sizeof(uint16_t));
 }

+/**
+ * Append a uint32_t to a buffer in network byte order.
+ *
+ * @param dest  Destination buffer.
+ * @param data  Value to append (converted with \c htonl()).
+ *
+ * @return true on success, false if there is insufficient capacity.
+ */
 static inline bool
 buf_write_u32(struct buffer *dest, uint32_t data)
 {
@@ -701,12 +1305,32 @@
     return buf_write(dest, &u32, sizeof(uint32_t));
 }

+/**
+ * Copy the content of one buffer to the end of another.
+ *
+ * @param dest  Destination buffer.
+ * @param src   Source buffer.
+ *
+ * @return true on success, false if \c dest has insufficient capacity.
+ */
 static inline bool
 buf_copy(struct buffer *dest, const struct buffer *src)
 {
     return buf_write(dest, BPTR(src), BLENZ(src));
 }

+/**
+ * Read \c n bytes from \c src and append them to \c dest.
+ *
+ * Consumes the bytes from \c src.
+ *
+ * @param dest  Destination buffer.
+ * @param src   Source buffer (modified).
+ * @param n     Number of bytes to copy.
+ *
+ * @return true on success, false if \c src has fewer than \c n bytes or
+ *         \c dest has insufficient capacity.
+ */
 static inline bool
 buf_copy_n(struct buffer *dest, struct buffer *src, int n)
 {
@@ -718,6 +1342,22 @@
     return buf_write(dest, cp, n);
 }

+/**
+ * Copy a range of bytes from one buffer into a specific position in anoth=
er.
+ *
+ * Copies \c src_len bytes starting at \c src_index within \c src content
+ * into \c dest at \c dest_index relative to the content start.  Updates
+ * \c dest->len if the write extends beyond the current content.  Does not
+ * advance either buffer's offset.
+ *
+ * @param dest        Destination buffer.
+ * @param dest_index  Byte offset within \c dest content to write at.
+ * @param src         Source buffer.
+ * @param src_index   Byte offset within \c src content to read from.
+ * @param src_len     Number of bytes to copy.
+ *
+ * @return true on success, false if any index or length is out of range.
+ */
 static inline bool
 buf_copy_range(struct buffer *dest, int dest_index, const struct buffer *s=
rc, int src_index,
                int src_len)
@@ -735,7 +1375,19 @@
     return true;
 }

-/* truncate src to len, copy excess data beyond len to dest */
+/**
+ * Truncate \c src to \c len bytes and copy any excess to \c dest.
+ *
+ * If \c src->len > \c len, \c src is truncated to \c len bytes and the
+ * remaining bytes are appended to \c dest.  If \c src->len <=3D \c len,
+ * nothing is copied and true is returned.
+ *
+ * @param dest  Destination buffer for the excess data.
+ * @param src   Source buffer to truncate.
+ * @param len   Maximum number of bytes to keep in \c src.
+ *
+ * @return true on success, false if \c len is negative or copying fails.
+ */
 static inline bool
 buf_copy_excess(struct buffer *dest, struct buffer *src, int len)
 {
@@ -759,6 +1411,17 @@
     }
 }

+/**
+ * Read bytes from the front of a buffer into a caller-supplied destinatio=
n.
+ *
+ * Consumes \c size bytes from \c src and copies them to \c dest.
+ *
+ * @param src   Source buffer (modified).
+ * @param dest  Destination memory.
+ * @param size  Number of bytes to read.
+ *
+ * @return true on success, false if \c src has fewer than \c size bytes.
+ */
 static inline bool
 buf_read(struct buffer *src, void *dest, int size)
 {
@@ -771,6 +1434,14 @@
     return true;
 }

+/**
+ * Return the first byte of the buffer without consuming it.
+ *
+ * @param buf   The buffer to peek at.
+ *
+ * @return The first byte as an unsigned value (0=E2=80=93255), or -1 if t=
he buffer
+ *         is empty.
+ */
 static inline int
 buf_peek_u8(struct buffer *buf)
 {
@@ -783,6 +1454,13 @@
     return ret;
 }

+/**
+ * Read and consume a uint8_t from the front of a buffer.
+ *
+ * @param buf   The buffer to read from.
+ *
+ * @return The byte value (0=E2=80=93255), or -1 if the buffer is empty.
+ */
 static inline int
 buf_read_u8(struct buffer *buf)
 {
@@ -794,6 +1472,16 @@
     return ret;
 }

+/**
+ * Read and consume a uint16_t from the front of a buffer.
+ *
+ * The value is converted from network byte order via \c ntohs().
+ *
+ * @param buf   The buffer to read from.
+ *
+ * @return The host-byte-order value, or -1 if the buffer has fewer than 2
+ *         bytes.
+ */
 static inline int
 buf_read_u16(struct buffer *buf)
 {
@@ -805,6 +1493,17 @@
     return ntohs(ret);
 }

+/**
+ * Read and consume a uint32_t from the front of a buffer.
+ *
+ * The value is converted from network byte order via \c ntohl().
+ *
+ * @param buf   The buffer to read from.
+ * @param good  If non-NULL, set to true on success or false on failure.
+ *
+ * @return The host-byte-order value, or 0 if the buffer has fewer than 4
+ *         bytes (check \c *good to distinguish from a legitimate zero).
+ */
 static inline uint32_t
 buf_read_u32(struct buffer *buf, bool *good)
 {
@@ -862,31 +1561,73 @@
     return memcmp(BPTR(src), match, size) =3D=3D 0;
 }

+/**
+ * Return true if the head of \c src matches the string \c match.
+ *
+ * Compares the first \c strlen(match) bytes of \c src content with \c mat=
ch.
+ * *NOT* constant time. Do not use when comparing HMACs.
+ *
+ * @param src    Buffer whose head is compared.
+ * @param match  Null-terminated string to compare against.
+ *
+ * @return true if the buffer starts with \c match.
+ */
 bool buf_string_match_head_str(const struct buffer *src, const char *match=
);

+/**
+ * Compare the head of \c src with \c match and advance past it if equal.
+ *
+ * If the buffer starts with \c match, the matched bytes are consumed from
+ * \c src.  *NOT* constant time. Do not use when comparing HMACs.
+ *
+ * @param src    Buffer to compare and advance.
+ * @param match  Null-terminated string to compare against.
+ *
+ * @return true if the buffer started with \c match (and was advanced).
+ */
 bool buf_string_compare_advance(struct buffer *src, const char *match);

+/**
+ * Return the length of the next token in a buffer up to a delimiter.
+ *
+ * Scans the buffer content for \c delim and returns the number of bytes
+ * up to (but not including) the delimiter, or the full buffer length if
+ * the delimiter is not found.
+ *
+ * @param buf    The buffer to scan.
+ * @param delim  Delimiter byte to search for.
+ *
+ * @return Number of bytes before the first occurrence of \c delim, or -1
+ *         if the buffer is empty.
+ */
 int buf_substring_len(const struct buffer *buf, int delim);

-/*
- * Print a string which might be NULL
+/**
+ * Return a printable representation of a string that might be NULL.
+ *
+ * @param str   String to print, or NULL.
+ *
+ * @return \c str if non-NULL, otherwise the string \c "[NULL]".
  */
 const char *np(const char *str);

-/* character classes */
-
+/** @name Character classes
+ *  @brief Check or modify strings based on classes of allowed
+ *         or forbidden characters.
+ */
+/**@{*/
 #define CC_ANY  (1 << 0)           /**< any character */
 #define CC_NULL (1 << 1)           /**< null character \0 */

-#define CC_ALNUM  (1 << 2)         /**< alphanumeric isalnum() */
-#define CC_ALPHA  (1 << 3)         /**< alphabetic isalpha() */
+#define CC_ALNUM  (1 << 2)         /**< alphanumeric \c isalnum() */
+#define CC_ALPHA  (1 << 3)         /**< alphabetic \c isalpha() */
 #define CC_ASCII  (1 << 4)         /**< ASCII character */
-#define CC_CNTRL  (1 << 5)         /**< control character iscntrl() */
-#define CC_DIGIT  (1 << 6)         /**< digit isdigit() */
+#define CC_CNTRL  (1 << 5)         /**< control character \c iscntrl() */
+#define CC_DIGIT  (1 << 6)         /**< digit \c isdigit() */
 #define CC_PRINT  (1 << 7)         /**< printable (>=3D 32, !=3D 127) */
-#define CC_PUNCT  (1 << 8)         /**< punctuation ispunct() */
-#define CC_SPACE  (1 << 9)         /**< whitespace isspace() */
-#define CC_XDIGIT (1 << 10)        /**< hex digit isxdigit() */
+#define CC_PUNCT  (1 << 8)         /**< punctuation \c ispunct() */
+#define CC_SPACE  (1 << 9)         /**< whitespace \c isspace() */
+#define CC_XDIGIT (1 << 10)        /**< hex digit \c isxdigit() */

 #define CC_BLANK   (1 << 11)       /**< space or tab */
 #define CC_NEWLINE (1 << 12)       /**< newline */
@@ -914,8 +1655,27 @@
 #define CC_NAME (CC_ALNUM | CC_UNDERBAR) /**< alphanumeric plus underscore=
 */
 #define CC_CRLF (CC_CR | CC_NEWLINE)     /**< carriage return or newline */

+/**
+ * Test whether a character belongs to one or more character classes.
+ *
+ * @param c      The character to test.
+ * @param flags  Bitmask of \c CC_* character class flags.
+ *
+ * @return true if \c c matches any of the classes specified in \c flags.
+ */
 bool char_class(const unsigned char c, const unsigned int flags);

+/**
+ * Test whether all characters in a string satisfy a character class filte=
r.
+ *
+ * @param str        The null-terminated string to test.
+ * @param inclusive  Classes that are permitted (characters must match at
+ *                   least one of these).
+ * @param exclusive  Classes that are forbidden (characters must not match
+ *                   any of these, even if they also match \c inclusive).
+ *
+ * @return true if every character in \c str is permitted.
+ */
 bool string_class(const char *str, const unsigned int inclusive, const uns=
igned int exclusive);

 /**
@@ -962,10 +1722,27 @@
  */
 const char *string_mod_const(const char *str, const unsigned int inclusive,
                              const unsigned int exclusive, const char repl=
ace, struct gc_arena *gc);
+/**@}*/

+/**
+ * Replace all leading occurrences of a character in a string.
+ *
+ * Scans from the start of \c str and replaces every consecutive \c match
+ * character with \c replace, stopping at the first character that does not
+ * match.
+ *
+ * @param str      The null-terminated string to modify in place.
+ * @param match    The character to replace.
+ * @param replace  The replacement character.
+ */
 void string_replace_leading(char *str, const char match, const char replac=
e);

-/** Return true iff str starts with prefix */
+/**
+ * Return true iff \c str starts with \c prefix.
+ *
+ * @param str     The string to test.
+ * @param prefix  The prefix to look for.
+ */
 static inline bool
 strprefix(const char *str, const char *prefix)
 {
@@ -1000,6 +1777,16 @@
  * Verify that a pointer is correctly aligned
  */
 #ifdef VERIFY_ALIGNMENT
+/**
+ * Assert that the content pointer of \c buf is 4-byte aligned.
+ *
+ * Only compiled in when \c VERIFY_ALIGNMENT is defined.  Called via the
+ * \c verify_align_4() macro.
+ *
+ * @param buf   Buffer whose content pointer is to be checked.
+ * @param file  Source file of the call site (for the error message).
+ * @param line  Source line of the call site (for the error message).
+ */
 void valign4(const struct buffer *buf, const char *file, const int line);

 #define verify_align_4(ptr) valign4(buf, __FILE__, __LINE__)
@@ -1007,23 +1794,58 @@
 #define verify_align_4(ptr)
 #endif

-/*
- * Very basic garbage collection, mostly for routines that return
- * char ptrs to malloced strings.
+/** @name Garbage Collection
+ *  @brief Basic garbage collection, mostly for routines that return
+ *         char ptrs to malloced strings.
  */
+/**@{*/

+/**
+ * Move all allocations from one garbage collection arena to another.
+ *
+ * After the call \c src is empty and all entries previously in \c src are
+ * owned by \c dest.
+ *
+ * @param dest  Arena to move allocations into.
+ * @param src   Arena to move allocations from (emptied on return).
+ */
 void gc_transfer(struct gc_arena *dest, struct gc_arena *src);

+/**
+ * Free all plain allocations in a garbage collection arena.
+ *
+ * Internal implementation called by \c gc_free().  Do not call directly.
+ *
+ * @param a  The arena whose \c list entries are to be freed.
+ */
 void x_gc_free(struct gc_arena *a);

+/**
+ * Free all specially-allocated entries in a garbage collection arena.
+ *
+ * Internal implementation called by \c gc_free().  Do not call directly.
+ * Invokes the custom free function stored in each \c gc_entry_special.
+ *
+ * @param a  The arena whose \c list_special entries are to be freed.
+ */
 void x_gc_freespecial(struct gc_arena *a);

+/**
+ * Return true iff the arena contains at least one allocation.
+ *
+ * @param a  The arena to test.
+ */
 static inline bool
 gc_defined(struct gc_arena *a)
 {
     return a->list !=3D NULL;
 }

+/**
+ * Initialise a garbage collection arena to an empty state.
+ *
+ * @param a  The arena to initialise.
+ */
 static inline void
 gc_init(struct gc_arena *a)
 {
@@ -1031,12 +1853,25 @@
     a->list_special =3D NULL;
 }

+/**
+ * Detach all allocations from an arena without freeing them.
+ *
+ * After this call the arena is empty.  The caller takes responsibility for
+ * freeing the previously registered allocations.
+ *
+ * @param a  The arena to detach.
+ */
 static inline void
 gc_detach(struct gc_arena *a)
 {
     gc_init(a);
 }

+/**
+ * Allocate and return a new, empty garbage collection arena.
+ *
+ * @return An initialised \c gc_arena with empty lists.
+ */
 static inline struct gc_arena
 gc_new(void)
 {
@@ -1045,6 +1880,14 @@
     return ret;
 }

+/**
+ * Free all allocations in a garbage collection arena.
+ *
+ * Calls \c x_gc_free() and \c x_gc_freespecial() as needed to release all
+ * registered memory.
+ *
+ * @param a  The arena to free.
+ */
 static inline void
 gc_free(struct gc_arena *a)
 {
@@ -1058,6 +1901,13 @@
     }
 }

+/**
+ * Free all allocations in a garbage collection arena and reinitialise it.
+ *
+ * Equivalent to calling \c gc_free() followed by \c gc_init().
+ *
+ * @param a  The arena to reset.
+ */
 static inline void
 gc_reset(struct gc_arena *a)
 {
@@ -1075,58 +1925,139 @@
 /* 1 GB on 32bit systems, they usually can only allocate 2 GB for the
  * whole process.
  */
+/** Maximum size for a single array allocation (checked by \c array_mult_s=
afe()). */
 #define ALLOC_SIZE_MAX (1u << 30)
 #else
+/** Maximum size for a single array allocation (checked by \c array_mult_s=
afe()). */
 #define ALLOC_SIZE_MAX ((size_t)1 << 32) /* 4 GB */
 #endif

+/**
+ * Allocate memory for a single object of the given type.
+ *
+ * Calls \c check_malloc_return() to abort on allocation failure.
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Type of the object to allocate.
+ */
 #define ALLOC_OBJ(dptr, type)                                       \
     {                                                               \
         check_malloc_return((dptr) =3D (type *)malloc(sizeof(type))); \
     }

+/**
+ * Allocate and zero-initialise memory for a single object of the given ty=
pe.
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Type of the object to allocate.
+ */
 #define ALLOC_OBJ_CLEAR(dptr, type)      \
     {                                    \
         ALLOC_OBJ(dptr, type);           \
         memset((dptr), 0, sizeof(type)); \
     }

+/**
+ * Allocate memory for an array of \c n elements of the given type.
+ *
+ * Uses \c array_mult_safe() to guard against size overflow.
+ * Calls \c check_malloc_return() to abort on allocation failure.
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Element type of the array.
+ * @param n     Number of elements.
+ */
 #define ALLOC_ARRAY(dptr, type, n)                                        =
                   \
     {                                                                     =
                   \
         check_malloc_return((dptr) =3D (type *)malloc(array_mult_safe(size=
of(type), (n), 0))); \
     }

+/**
+ * Allocate a garbage-collected array of \c n elements of the given type.
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Element type of the array.
+ * @param n     Number of elements.
+ * @param gc    Garbage collection arena to register the allocation with.
+ */
 #define ALLOC_ARRAY_GC(dptr, type, n, gc)                                 =
              \
     {                                                                     =
              \
         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(type), (n), 0)=
, false, (gc)); \
     }

+/**
+ * Allocate and zero-initialise an array of \c n elements of the given typ=
e.
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Element type of the array.
+ * @param n     Number of elements.
+ */
 #define ALLOC_ARRAY_CLEAR(dptr, type, n)                            \
     {                                                               \
         ALLOC_ARRAY(dptr, type, n);                                 \
         memset((dptr), 0, (array_mult_safe(sizeof(type), (n), 0))); \
     }

+/**
+ * Allocate and zero-initialise a garbage-collected array of \c n elements.
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Element type of the array.
+ * @param n     Number of elements.
+ * @param gc    Garbage collection arena to register the allocation with.
+ */
 #define ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc)                           =
             \
     {                                                                     =
             \
         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(type), (n), 0)=
, true, (gc)); \
     }

+/**
+ * Allocate and zero-initialise a garbage-collected variable-length struct=
ure.
+ *
+ * Allocates \c sizeof(type) + \c n * \c sizeof(atype) bytes for a structu=
re
+ * that embeds a variable-length array of \c atype as its last member.
+ *
+ * @param dptr   Pointer variable that receives the allocation.
+ * @param type   Type of the enclosing structure.
+ * @param atype  Element type of the variable-length array member.
+ * @param n      Number of array elements.
+ * @param gc     Garbage collection arena to register the allocation with.
+ */
 #define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, atype, n, gc)                =
                         \
     {                                                                     =
                         \
         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(atype), (n), s=
izeof(type)), true, (gc)); \
     }

+/**
+ * Allocate a garbage-collected object of the given type (uninitialised).
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Type of the object to allocate.
+ * @param gc    Garbage collection arena to register the allocation with.
+ */
 #define ALLOC_OBJ_GC(dptr, type, gc)                           \
     {                                                          \
         (dptr) =3D (type *)gc_malloc(sizeof(type), false, (gc)); \
     }

+/**
+ * Allocate and zero-initialise a garbage-collected object of the given ty=
pe.
+ *
+ * @param dptr  Pointer variable that receives the allocation.
+ * @param type  Type of the object to allocate.
+ * @param gc    Garbage collection arena to register the allocation with.
+ */
 #define ALLOC_OBJ_CLEAR_GC(dptr, type, gc)                    \
     {                                                         \
         (dptr) =3D (type *)gc_malloc(sizeof(type), true, (gc)); \
     }

+/**
+ * Abort if a memory allocation returned NULL.
+ *
+ * @param p  Return value from \c malloc() or similar; calls \c out_of_mem=
ory()
+ *           if \c p is NULL.
+ */
 static inline void
 check_malloc_return(void *p)
 {
@@ -1135,22 +2066,28 @@
         out_of_memory();
     }
 }
+/**@}*/
+/* End of GC */

-/*
- * Manage lists of buffers
+/** @name Buffer Lists
+ *  @brief Manage lists of buffers
  */
+/**@{*/
+
+/** One node in a \c buffer_list linked list. */
 struct buffer_entry
 {
-    struct buffer buf;
-    struct buffer_entry *next;
+    struct buffer buf;         /**< The buffer stored in this list node. */
+    struct buffer_entry *next; /**< Pointer to the next node, or NULL. */
 };

+/** A singly-linked list of buffers, with head/tail pointers for O(1) push=
. */
 struct buffer_list
 {
-    struct buffer_entry *head; /* next item to pop/peek */
-    struct buffer_entry *tail; /* last item pushed */
-    int size;                  /* current number of entries */
-    int max_size;              /* maximum size list should grow to */
+    struct buffer_entry *head; /**< Next item to pop/peek. */
+    struct buffer_entry *tail; /**< Last item pushed. */
+    int size;                  /**< Current number of entries. */
+    int max_size;              /**< Maximum number of entries allowed. */
 };

 /**
@@ -1211,8 +2148,24 @@
  */
 struct buffer *buffer_list_peek(struct buffer_list *ol);

+/**
+ * Advance past \c n bytes in the head buffer, popping it if it becomes em=
pty.
+ *
+ * \c n must not exceed the length of the head buffer; passing a larger va=
lue
+ * triggers an assertion failure.
+ *
+ * @param ol  The list whose head buffer is to be advanced.
+ * @param n   Number of bytes to skip in the head buffer.
+ */
 void buffer_list_advance(struct buffer_list *ol, ssize_t n);

+/**
+ * Remove and free the head buffer of the list.
+ *
+ * Does nothing if \c ol is NULL or empty.
+ *
+ * @param ol  The list to pop from.
+ */
 void buffer_list_pop(struct buffer_list *ol);

 /**
@@ -1240,6 +2193,20 @@
  */
 void buffer_list_aggregate_separator(struct buffer_list *bl, const size_t =
max_len, const char *sep);

+/**
+ * Read a file into a buffer list, one buffer per line.
+ *
+ * Opens \c fn for reading and pushes each line into a newly allocated buf=
fer
+ * list using \c fgets().  Lines longer than \c max_line_len - 1 bytes are
+ * split across multiple consecutive buffers.
+ *
+ * @param fn            Path to the file to read.
+ * @param max_line_len  Maximum number of bytes (including null terminator)
+ *                      read per \c fgets() call.
+ *
+ * @return Pointer to the new buffer list, or NULL if the file could not be
+ *         opened or memory allocation failed.
+ */
 struct buffer_list *buffer_list_file(const char *fn, int max_line_len);

 /**
@@ -1253,5 +2220,7 @@
  * error
  */
 struct buffer buffer_read_from_file(const char *filename, struct gc_arena =
*gc);
+/**@}*/
+/* End of Buffer Lists */

 #endif /* BUFFER_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1581?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
Gerrit-Change-Number: 1581
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--YNoDRP2CEbE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1581?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">doc: add Doxygen documentation to buffer.h<=
br><br>Document all previously undocumented elements.<br><br>Github: Fixes =
#864<br>Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/buff=
er.h<br>1 file changed, 1,032 insertions(+), 63 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/8=
1/1581/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</=
span><br><span>index 040f752..87d7d80 100644</span><br><span>--- a/src/open=
vpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ =
-20,12 +20,22 @@</span><br><span>  *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @brief Buffer management functions and garbage =
collection.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This module provides t=
he core \c buffer type used throughout OpenVPN to</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * hold packet data, as well as a simple memo=
ry management system</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * (\c gc_arena / \c gc_malloc()) and various string/memory utility functi=
ons.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifndef BUFFE=
R_H</span><br><span> #define BUFFER_H</span><br><span> </span><br><span> #i=
nclude &quot;basic.h&quot;</span><br><span> #include &quot;error.h&quot;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** =
Maximum allowed size (in bytes) for a single buffer allocation. */</span><b=
r><span> #define BUF_SIZE_MAX 1000000</span><br><span> </span><br><span> /*=
</span><br><span>@@ -114,36 +124,119 @@</span><br><span>  */</span><br><spa=
n> struct gc_arena</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct gc_entry *list; /**&lt; First element of the lin=
ked list of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                  *   \c gc_entry structures. */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct gc_entry_special *list_special;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_entry *list=
;                 /**&lt; First element of the linked list of</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           *   \c gc_entry structures. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_entry_special *list_special; /**&lt; Fi=
rst element of the linked</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                            *   list of \c gc_entry_s=
pecial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                               *   structures for allocations</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           *   requiring a custom free</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                            *   function=
. */</span><br><span> };</span><br><span> </span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** Return a pointer to the start =
of the buffer content. @see buf_bptr() */</span><br><span> #define BPTR(buf=
)  (buf_bptr(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
** Return a pointer one past the end of the buffer content. @see buf_bend()=
 */</span><br><span> #define BEND(buf)  (buf_bend(buf))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/** Return a pointer to the last byte o=
f the buffer content, or NULL if empty. @see buf_blast() */</span><br><span=
> #define BLAST(buf) (buf_blast(buf))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/** Return the length of the buffer content in bytes. @se=
e buf_len() */</span><br><span> #define BLEN(buf)  (buf_len(buf))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/** Return the length of the =
buffer content as a \c size_t. @see buf_len() */</span><br><span> #define B=
LENZ(buf) ((size_t)buf_len(buf))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/** Return true iff the buffer is defined (has non-NULL data p=
ointer). @see buf_defined() */</span><br><span> #define BDEF(buf)  (buf_def=
ined(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Retur=
n the buffer content pointer cast to \c char *. @see buf_str() */</span><br=
><span> #define BSTR(buf)  (buf_str(buf))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** Return the number of bytes available for appendin=
g to the buffer. @see buf_forward_capacity() */</span><br><span> #define BC=
AP(buf)  (buf_forward_capacity(buf))</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Zeroise and reset a buffer.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Sets all allocated memory to zero and resets \c offset and =
\c len to zero,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * b=
ut does not free the underlying memory.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param buf   The buffer to clear.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span> void buf_clear(struct buffer *buf)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free the memo=
ry allocated for a buffer.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Frees \=
c buf-&gt;data and resets the buffer to an undefined state.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf   The buffer whose memory is to be fre=
ed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> void free_buf(struct buffer *buf);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Assign the content of one buffer to another.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Copies the content of \c src into \c d=
est.  The destination buffer must</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * already be allocated with sufficient capacity.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param dest  Destination buffer to write into=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src   So=
urce buffer to read from.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
true on success, false if \c dest has insufficient capacity.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool buf_assi=
gn(struct buffer *dest, const struct buffer *src);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Securely clear a null-terminated strin=
g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Overwrites all characters of \c=
 str with zeroes.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str   The=
 string to clear.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span> void string_clear(char *str);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Return the number of elements in a NULL-t=
erminated array of strings.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 array     NULL-terminated array of string pointers.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return Number of non-NULL elements.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> int string_array_=
len(const char **array);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Safely compute the product of two sizes plus an extra amount.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Each of \c m1, \c m2, and \c extra, a=
s well as the final result, are</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * checked against \c ALLOC_SIZE_MAX.  If any value exceeds the=
 limit the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * functi=
on calls \c msg(M_FATAL) and does not return.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param m1    First multiplicand.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param m2    Second multiplicand.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param extra Value to add to t=
he product.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return \c m1 * \c m2 =
+ \c extra.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span> size_t array_mult_safe(const size_t m1, const size_t m2, const=
 size_t extra);</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/** Flag for print_argv(): wrap each argument in square brack=
ets. */</span><br><span> #define PA_BRACKET (1 &lt;&lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Format a NULL-terminated argument vector as a sin=
gle string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p     NULL-term=
inated array of string pointers to format.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param gc    Garbage collection arena for the ret=
urned string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram flags Formatting flags (e.g. \c PA_BRACKET).</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return Newly allocated string representation of \c p.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> char=
 *print_argv(const char **p, struct gc_arena *gc, const unsigned int flags)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Report a buff=
er size error and abort.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Called wh=
en a requested buffer size exceeds \c BUF_SIZE_MAX or is otherwise</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * invalid.  Calls \c msg(M_=
FATAL) and does not return.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 size  The invalid size that was requested.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span> void buf_size_error(const size=
_t size);</span><br><span> </span><br><span> /* for dmalloc debugging */</s=
pan><br><span>@@ -157,36 +250,121 @@</span><br><span> #define string_alloc(=
str, gc)         string_alloc_debug(str, gc, __FILE__, __LINE__)</span><br>=
<span> #define string_alloc_buf(str, gc)     string_alloc_buf_debug(str, gc=
, __FILE__, __LINE__)</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** Debug variant of \c alloc_buf() that records the al=
location site. */</span><br><span> struct buffer alloc_buf_debug(size_t siz=
e, const char *file, int line);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/** Debug variant of \c alloc_buf_gc() that r=
ecords the allocation site. */</span><br><span> struct buffer alloc_buf_gc_=
debug(size_t size, struct gc_arena *gc, const char *file, int line);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Debu=
g variant of \c clone_buf() that records the allocation site. */</span><br>=
<span> struct buffer clone_buf_debug(const struct buffer *buf, const char *=
file, int line);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/** Debug variant of \c gc_malloc() that records the allocat=
ion site. */</span><br><span> void *gc_malloc_debug(size_t size, bool clear=
, struct gc_arena *a, const char *file, int line);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/** Debug variant of \c st=
ring_alloc() that records the allocation site. */</span><br><span> char *st=
ring_alloc_debug(const char *str, struct gc_arena *gc, const char *file, in=
t line);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/** Debug variant of \c string_alloc_buf() that records the allocati=
on site. */</span><br><span> struct buffer string_alloc_buf_debug(const cha=
r *str, struct gc_arena *gc, const char *file,</span><br><span>            =
                          int line);</span><br><span> </span><br><span> #el=
se  /* ifdef DMALLOC */</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Allocate a buffer of the given size.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Calls \c out_of_memory() if the allocation fails. The caller is=
 responsible</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for =
freeing the memory.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  N=
umber of bytes to allocate.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n Newly allocated buffer of capacity \c size.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span> struct buffer alloc_buf(size=
_t size);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-struct buffer alloc_buf_gc(size_t size,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                           struct gc_arena *gc); /*=
 allocate buffer with garbage collection */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Allocate a buffer of the given size under garbage collection.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * The allocated memory is registered w=
ith \c gc so that it is freed when</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * \c gc_free() is called on the arena.  Calls \c out_of_mem=
ory() if the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allo=
cation fails.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number =
of bytes to allocate.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param gc    Garbage collection arena to register the allocation with.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return Newly allocated buffer of=
 capacity \c size.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer all=
oc_buf_gc(size_t size, struct gc_arena *gc);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Duplicate a buffer, including its content.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Allocates a new buffer with the same=
 capacity as \c buf and copies its</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * content.  Calls \c out_of_memory() if the allocation fail=
s.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to dupl=
icate.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return A newly allocated c=
opy of \c buf.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span> struct buffer clone_buf(const struct buffer *buf);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate memory and, op=
tionally, zero it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The allocation =
is registered with \c a so that it is freed when</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * \c gc_free() is called on the arena.  Calls=
 \c out_of_memory() if the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * allocation fails.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 size  Number of bytes to allocate.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param clear If true, zeroise the allocated memory befor=
e returning.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am a     Garbage collection arena to register the allocation with.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return Pointer to the newly allocated mem=
ory.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span> void *gc_malloc(size_t size, bool clear, struct gc_arena *a);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Duplicate a string, al=
locating memory under garbage collection.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param str   The string to duplicate.  May be NULL, in which case N=
ULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
is returned.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am gc    Garbage collection arena for the returned string, or NULL</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *              to use plain=
 \c malloc().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return A newly allo=
cated copy of \c str, or NULL if \c str is NULL.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span> char *string_alloc(const =
char *str, struct gc_arena *gc);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Allocate a buffer containing a copy of the given string.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Wraps \c string_alloc(), so \c gc =
may be NULL (plain \c malloc() is used</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * in that case).  The buffer \c len reflects the string=
 length, excluding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* the null terminator, even though the terminator is present in the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * allocated memory.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param str   The string to copy into t=
he buffer.  Must not be NULL.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param gc    Garbage collection arena for the allocation, or N=
ULL.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return A buffer whose conten=
t is a copy of \c str.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span> struct buffer string_alloc_buf(const char *str, str=
uct gc_arena *gc);</span><br><span> </span><br><span> #endif /* ifdef DMALL=
OC */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Register =
an address with a custom free function in a garbage collection</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * arena.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * When \c gc_free() is called on \c a, \c free_function(a=
ddr) will be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * invo=
ked to release the memory.  Use this for allocations that require</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * something other than plain=
 \c free(), such as \c freeaddrinfo().</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param addr          Pointer to the memory to register.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param free_function Function t=
o call to free \c addr.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param a             Garbage collection arena to register with.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> voi=
d gc_addspecial(void *addr, void (*free_function)(void *), struct gc_arena =
*a);</span><br><span> </span><br><span> /**</span><br><span>@@ -204,6 +382,=
7 @@</span><br><span> </span><br><span> #ifdef BUF_INIT_TRACKING</span><br>=
<span> #define buf_init(buf, offset) buf_init_debug(buf, offset, __FILE__, =
__LINE__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Debug =
variant of \c buf_init_dowork() that records the call site for alignment ve=
rification. */</span><br><span> bool buf_init_debug(struct buffer *buf, int=
 offset, const char *file, int line);</span><br><span> </span><br><span> #e=
lse</span><br><span>@@ -212,31 +391,62 @@</span><br><span> </span><br><span=
> </span><br><span> /* inline functions */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Callback =
to free a \c struct \c addrinfo, suitable for use with</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * \c gc_addspecial().</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param addr  Pointer to the \c struct \c addrinfo t=
o free.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span> static inline void</span><br><span> gc_freeaddrinfo_callback(void =
*addr)</span><br><span> {</span><br><span>     freeaddrinfo((struct addrinf=
o *)addr);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/** Return an empty struct buffer */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/** Return an empty, undefined \=
c struct \c buffer (all fields zero). */</span><br><span> static inline str=
uct buffer</span><br><span> clear_buf(void)</span><br><span> {</span><br><s=
pan>     return (struct buffer){ 0 };</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Return true iff \c buf has a non-=
NULL data pointer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A defined buffe=
r has been allocated but may have zero length or negative</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * len (i.e. it is not necessarily va=
lid).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to t=
est.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span> static inline bool</span><br><span> buf_defined(const struct buffer *=
buf)</span><br><span> {</span><br><span>     return buf-&gt;data !=3D NULL;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Return true iff \c buf is valid.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * A buffer is valid when its data pointer is non-NULL and its \c len is</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * non-negative.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to test.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> stat=
ic inline bool</span><br><span> buf_valid(const struct buffer *buf)</span><=
br><span> {</span><br><span>     return likely(buf-&gt;data !=3D NULL) &amp=
;&amp; likely(buf-&gt;len &gt;=3D 0);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer to the start of =
the buffer content.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   T=
he buffer to query.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointe=
r to \c buf-&gt;data + \c buf-&gt;offset, or NULL if \c buf is</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *         not valid.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static in=
line uint8_t *</span><br><span> buf_bptr(const struct buffer *buf)</span><b=
r><span> {</span><br><span>@@ -250,6 +460,13 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Return the length of the buffer content.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param buf   The buffer to query.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return \c buf-&gt;len if \c buf is valid, otherwise 0.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static int<=
/span><br><span> buf_len(const struct buffer *buf)</span><br><span> {</span=
><br><span>@@ -263,12 +480,27 @@</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointe=
r one past the end of the buffer content.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param buf   The buffer to query.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return Pointer to the byte immediately after the last content byte=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n> static inline uint8_t *</span><br><span> buf_bend(const struct buffer *b=
uf)</span><br><span> {</span><br><span>     return buf_bptr(buf) + buf_len(=
buf);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Return a pointer to the last byte of the buffer content.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to query.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return Pointer to the last byte, or NULL =
if the buffer is empty or</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *         invalid.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span> static inline uint8_t *</span><br><span> buf_bla=
st(const struct buffer *buf)</span><br><span> {</span><br><span>@@ -282,24 =
+514,56 @@</span><br><span>     }</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Return true iff \c size is within the=
 allowed buffer size range.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 size  The size to check.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
true if \c size &lt; \c BUF_SIZE_MAX.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span> static inline bool</span><br><span> =
buf_size_valid(const size_t size)</span><br><span> {</span><br><span>     r=
eturn likely(size &lt; BUF_SIZE_MAX);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Return true iff a signed \c size =
is within the allowed buffer size range.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Accepts negative values (used for bidirectional length adjustments) =
as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * long as the ab=
solute value is below \c BUF_SIZE_MAX.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param size  The signed size to check.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return true if \c -BUF_SIZE_MAX &lt;=3D size &lt; \c BUF_SIZE_MA=
X.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an> static inline bool</span><br><span> buf_size_valid_signed(const int siz=
e)</span><br><span> {</span><br><span>     return likely(size &gt;=3D -BUF_=
SIZE_MAX) &amp;&amp; likely(size &lt; BUF_SIZE_MAX);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the buffer =
content pointer cast to \c char *.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param buf   The buffer to query.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return The content pointer as a \c char *, or NULL if \c buf is invalid.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span>=
 static inline char *</span><br><span> buf_str(const struct buffer *buf)</s=
pan><br><span> {</span><br><span>     return (char *)buf_bptr(buf);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Res=
et a buffer to an undefined (unallocated) state.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Sets all fields to zero/NULL without freeing any memory.  Us=
e \c free_buf()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * f=
irst if the buffer owns allocated memory.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param buf   The buffer to reset.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><br><sp=
an> buf_reset(struct buffer *buf)</span><br><span> {</span><br><span>@@ -30=
9,6 +573,14 @@</span><br><span>     buf-&gt;data =3D NULL;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reset the le=
ngth and offset of a buffer to zero.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * The underlying allocation is preserved and \c capacity is unchanged.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Equivalent to rewind=
ing the buffer to the beginning for fresh writing.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param buf   The buffer to reset.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</spa=
n><br><span> buf_reset_len(struct buffer *buf)</span><br><span> {</span><br=
><span>@@ -316,6 +588,18 @@</span><br><span>     buf-&gt;offset =3D 0;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Initialise a buffer with a given initial offset.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Sets \c buf-&gt;len to zero and \c buf-&gt;offset to \c offs=
et.  The buffer must</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * already be allocated.  Returns false (without modifying \c buf) if \c o=
ffset</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is negative=
, exceeds the buffer capacity, or the data pointer is NULL.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf     The buffer to initialise.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param offset  Initial by=
te offset from the start of the allocated memory.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return true on success, false if the parameters are invali=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an> static inline bool</span><br><span> buf_init_dowork(struct buffer *buf,=
 int offset)</span><br><span> {</span><br><span>@@ -328,6 +612,17 @@</span>=
<br><span>     return true;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Initialise a buffer with an externally prov=
ided writable memory region.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets =
up \c buf to use \c data as its backing store for writing.  The first</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * byte of \c data is set=
 to zero.  Calls \c buf_size_error() (which does not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * return) if \c size exceeds \c BUF_SIZE=
_MAX.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to i=
nitialise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 data  Pointer to the memory region to use.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param size  Size of the memory region in bytes.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
> static inline void</span><br><span> buf_set_write(struct buffer *buf, uin=
t8_t *data, int size)</span><br><span> {</span><br><span>@@ -345,6 +640,18 =
@@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Initialise a buffer with an externally provid=
ed read-only memory region.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets u=
p \c buf so that the entire \c data region is the buffer content</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * (offset is 0, len and capac=
ity are both set to \c size).  The data pointer</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * is cast away from const.  Calls \c buf_size_=
error() (which does not return)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * if \c size exceeds \c BUF_SIZE_MAX.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param buf   The buffer to initialise.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param data  Pointer to the read-onl=
y memory region.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param size  Size of the memory region in bytes.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span>=
<br><span> buf_set_read(struct buffer *buf, const uint8_t *data, size_t siz=
e)</span><br><span> {</span><br><span>@@ -357,7 +664,17 @@</span><br><span>=
     buf-&gt;data =3D (uint8_t *)data;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Like strncpy but m=
akes sure dest is always null terminated */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Like \c strncpy() but always null-terminates the destination.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Copies at most \c maxlen - 1 charact=
ers from \c src into \c dest and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * writes a null terminator at \c dest[\c maxlen - 1].  Does n=
othing if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c maxl=
en is zero.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest    Destina=
tion buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am src     Source string.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param maxlen  Size of the destination buffer in bytes.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static in=
line void</span><br><span> strncpynt(char *dest, const char *src, size_t ma=
xlen)</span><br><span> {</span><br><span>@@ -368,7 +685,13 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* return true if string contains at least one num=
erical digit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return true if th=
e string contains at least one decimal digit.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param src   The null-terminated string to scan.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true if any character in \c src satisfie=
s \c isdigit().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span> static inline bool</span><br><span> has_digit(const char *=
src)</span><br><span> {</span><br><span>@@ -428,11 +751,20 @@</span><br><sp=
an> #endif</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * printf append to a buffer with overflow check,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * due to usage of vsnprintf, it will le=
ave space for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a fin=
al null character and thus use only</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * capacity - 1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pri=
ntf-style append to a buffer with overflow check.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Formats a string and appends it to \c buf.  Due to the use =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c vsnprintf()=
, one byte of forward capacity is reserved for a null</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * terminator, so at most \c buf_forward_=
capacity(buf) - 1 bytes of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * formatted output are written.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param buf     The buffer to append to.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param format  printf-style format string.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ...     Forma=
t arguments.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the e=
ntire formatted string fit in the buffer, false if</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *         it was truncated.</span><br><span=
>  */</span><br><span> bool buf_printf(struct buffer *buf, const char *form=
at, ...)</span><br><span> #ifdef __GNUC__</span><br><span>@@ -444,8 +776,13=
 @@</span><br><span> #endif</span><br><span>     ;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * puts append to a buffer with overflow check<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Append a string to a buffer with =
overflow check.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The b=
uffer to append to.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param str   The null-terminated string to append.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true if the string fit in the buffer, false if =
it was truncated.</span><br><span>  */</span><br><span> bool buf_puts(struc=
t buffer *buf, const char *str);</span><br><span> </span><br><span>@@ -454,=
22 +791,76 @@</span><br><span>  * remove/add trailing characters</span><br>=
<span>  */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Forc=
e a null terminator at the end of the buffer content.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * If there is free capacity, a &#39;\\0&#39; byte is appe=
nded.  If the buffer is</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * full, the last content byte is overwritten with &#39;\\0&#39; (i.e. =
the last</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * characte=
r is truncated to make room).  The function has no effect on an</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * empty or invalid buffer.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to null-termi=
nate.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span> void buf_null_terminate(struct buffer *buf);</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Remove trailing newline and carriage-r=
eturn characters from a buffer.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram buf   The buffer to chomp.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> void buf_chomp(struct buffer *buf);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove all occurrence=
s of a specific byte from the end of a buffer.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buf     The buffer to modify.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param remove  The byte value to strip fro=
m the tail.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span> void buf_rmtail(struct buffer *buf, uint8_t remove);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * non-buffer string functions</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** @name String Util=
ity Functions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @b=
rief Non-buffer string functions</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
@{*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Remove trailing newline and carriage-return cha=
racters from a string.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str =
  The null-terminated string to chomp.</span><br><span>  */</span><br><span=
> void chomp(char *str);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Remove all trailing characters that appear in a given set.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param str             The null-termin=
ated string to modify in place.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param what_to_delete  Null-terminated set of characters to =
strip.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> void rm_trailing_chars(char *str, const char *what_to_delete);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer pa=
st any leading whitespace in a string.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param str   The string to skip whitespace in.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return Pointer to the first non-whitespace character, =
or to the null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
      terminator if \c str is all whitespace.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span> const char *skip_leading_whi=
tespace(const char *str);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Null-terminate a fixed-length string buffer.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Ensures that \c str[\c len] is &#39;\\0&#39;, clampin=
g \c len to \c capacity - 1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * if necessary.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param st=
r       The character buffer to null-terminate.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param len       Current string length.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param capacity  Tota=
l size of the character buffer in bytes.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span> void string_null_terminate(char *=
str, int len, int capacity);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
End of string utility functions */</span><br><span> </span><br><span> /**</=
span><br><span>  * Write buffer contents to file.</span><br><span>@@ -481,4=
0 +872,114 @@</span><br><span>  */</span><br><span> bool buffer_write_file(=
const char *filename, const struct buffer *buf);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * write a string to the end of a buffer that was=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * truncated by buf_p=
rintf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Append a string to the phys=
ical end of a buffer that was truncated by</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * \c buf_printf().</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * If the buffer&#39;s forward capacity is one byte or less (i.e. it =
is full),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \c str =
is written at the very end of the allocated memory to act as a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * truncation marker, provided i=
t fits within the total buffer capacity.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * This is used to append a &quot;[more...]&quot; suff=
ix after hex-dump truncation.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buf   The buffer to append the truncation marker to.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param str   The null-terminated mar=
ker string to write.</span><br><span>  */</span><br><span> void buf_catrunc=
(struct buffer *buf, const char *str);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Parse a string based on a given delimiter char</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Extract the next token from a buffer, deli=
mited by a given character.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reads =
bytes from \c buf one at a time until \c delim or end-of-buffer is</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * encountered.  The token (=
without the delimiter) is written into \c line,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * which is always null-terminated.  The delimi=
ter byte is consumed from</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * \c buf but not included in \c line.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param buf    Source buffer to parse.  The consumed portion is a=
dvanced.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param d=
elim  Delimiter character.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param line   Output buffer for the extracted token.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param size   Size of \c line=
 in bytes (must be &gt; 0).</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n false only when end-of-buffer is reached and no characters were</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *         extracted; true ot=
herwise (including when a delimiter was found</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *         or \c line was truncated).</span><br><=
span>  */</span><br><span> bool buf_parse(struct buffer *buf, const int del=
im, char *line, const int size);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Hex dump -- Output a binary buffer to a hex string and return =
it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** @name Hex Du=
mp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @brief Output=
 a binary buffer to a hex string and return it.</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define FHE_SPACE_BREAK_MASK=
 0xFF  /* space_break parameter in lower 8 bits */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define FHE_CAPS             0x100 /* output h=
ex in caps */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/** Mask for the space_break_flags fi=
eld of \c format_hex_ex(): number of</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  bytes between separators (lower 8 bits). */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define FHE_SPACE_BREAK_MASK 0=
xFF</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Flag for \c =
format_hex_ex(): output hex digits in upper case. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define FHE_CAPS             0x100</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Format a binary buffer as a hex string=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param data              Pointer=
 to the binary data to format.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param size              Number of bytes to format.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param maxoutput         M=
aximum number of output characters (0 =3D unlimited).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                          If the output=
 is truncated, a &quot;[more...]&quot; suffix is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                          appended via \c bu=
f_catrunc().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am space_break_flags Lower 8 bits (\c FHE_SPACE_BREAK_MASK) give the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *                        =
  number of bytes between \c separator insertions.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *                          Use \c FHE_CAPS =
to output upper-case hex digits.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param separator         String to insert between groups of=
 bytes.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc=
                Garbage collection arena for the returned string.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return Null-terminated hex string allocate=
d from \c gc.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> char *format_hex_ex(const uint8_t *data, size_t size, size_t=
 maxoutput, unsigned int space_break_flags,</span><br><span>               =
      const char *separator, struct gc_arena *gc);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Format a binary buffer as a hex string=
 with spaces every 4 bytes.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Conven=
ience wrapper around \c format_hex_ex().</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param data       Pointer to the binary data to format.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param size       Number of b=
ytes to format.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param maxoutput  Maximum number of output characters (0 =3D unlimited).</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc         Ga=
rbage collection arena for the returned string.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return Null-terminated hex string allocated from \c gc.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> sta=
tic inline char *</span><br><span> format_hex(const uint8_t *data, size_t s=
ize, size_t maxoutput, struct gc_arena *gc)</span><br><span> {</span><br><s=
pan>     return format_hex_ex(data, size, maxoutput, 4, &quot; &quot;, gc);=
</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**@}*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* End of He=
x Dump */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return a b=
uffer that is a subset of another buffer.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Return a sub-buffer of another buffer.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Either allocates \c size bytes from the front or back of \c b=
uf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * shrinking \c =
buf accordingly, and returns a buffer pointing into the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * same memory.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf      Source buffer to carve the sub-buffer f=
rom.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size =
    Number of bytes to include in the sub-buffer.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param prepend  If true, take bytes from t=
he front of \c buf (prepend</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                 space); if false, take bytes from the end (appen=
d space).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return A buffer referen=
cing the allocated region, or an undefined buffer</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *         if \c buf has insufficient capacit=
y.</span><br><span>  */</span><br><span> struct buffer buf_sub(struct buffe=
r *buf, int size, bool prepend);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Check if sufficient space to append to buffer.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Check whether \c len bytes can be appended to a =
buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to=
 check.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param le=
n   Number of bytes to append.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn true if \c buf is valid, \c len is within the allowed range, and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         there is suffi=
cient capacity after the current content.</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline bo=
ol</span><br><span> buf_safe(const struct buffer *buf, size_t len)</span><b=
r><span> {</span><br><span>@@ -522,6 +987,18 @@</span><br><span>           =
 &amp;&amp; buf-&gt;offset + buf-&gt;len + (int)len &lt;=3D buf-&gt;capacit=
y;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Check whether \c len bytes can be added to or removed from a buffer.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Accepts negative \c len to verify=
 that bytes can be removed (length</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * decreased).</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buf   The buffer to check.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param len   Number of bytes to add (positive) or remove (nega=
tive).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the resulti=
ng length would remain non-negative and within</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *         the allocated capacity.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inlin=
e bool</span><br><span> buf_safe_bidir(const struct buffer *buf, int len)</=
span><br><span> {</span><br><span>@@ -536,6 +1013,17 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Return the number of bytes that can still be appended to the buffer=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * This is the space between the en=
d of the current content and the end of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * the allocated memory.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param buf   The buffer to query.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return Number of bytes available for appending, or 0 if \c buf =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         invali=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an> static inline int</span><br><span> buf_forward_capacity(const struct bu=
ffer *buf)</span><br><span> {</span><br><span>@@ -554,6 +1042,17 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Return the total number of bytes available from the cu=
rrent offset to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * end of the allocated memory.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Un=
like \c buf_forward_capacity(), this includes the bytes already occupied</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by the current cont=
ent.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to qu=
ery.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return Capacity minus offset=
, or 0 if \c buf is invalid.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span> static inline int</span><br><span> buf_forwar=
d_capacity_total(const struct buffer *buf)</span><br><span> {</span><br><sp=
an>@@ -572,6 +1071,16 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the number of by=
tes available for prepending to the buffer.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * This is the number of bytes between the start of the allocated me=
mory and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the curr=
ent content start (i.e. \c buf-&gt;offset).</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param buf   The buffer to query.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return \c buf-&gt;offset, or 0 if \c buf is invalid.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inl=
ine int</span><br><span> buf_reverse_capacity(const struct buffer *buf)</sp=
an><br><span> {</span><br><span>@@ -585,6 +1094,17 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Increase or decrease the length of a buffer.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Adjusts \c buf-&gt;len by \c inc bytes.  A negative \c inc=
 shrinks the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buff=
er.  The operation is bounds-checked via \c buf_safe_bidir().</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param buf   The buffer to modify.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param inc   Number of bytes =
to add to the length (may be negative).</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return true on success, false if the adjustment would violate bounds=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n> static inline bool</span><br><span> buf_inc_len(struct buffer *buf, int =
inc)</span><br><span> {</span><br><span>@@ -596,11 +1116,18 @@</span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Make space to prepend to a buffer.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Return NULL if no space.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Make space at the front of a buffer for prepen=
ding data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Moves the content start=
 backwards by \c size bytes, increasing \c len</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * and decreasing \c offset by the same amount.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to modify.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Num=
ber of bytes to reserve for prepending.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return Pointer to the newly reserved space (new content start), or N=
ULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         if \c=
 buf is invalid or there is insufficient prepend capacity.</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 static inline uint8_t *</span><br><span> buf_prepend(struct buffer *buf, s=
size_t size)</span><br><span> {</span><br><span>@@ -613,6 +1140,17 @@</span=
><br><span>     return BPTR(buf);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Advance the content start of a buffer=
, consuming bytes from the front.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Increases \c offset and decreases \c len by \c size bytes.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param buf   The buffer to advance.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of bytes to=
 skip.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fa=
lse if \c buf is invalid or \c size exceeds</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *         the current length.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool<=
/span><br><span> buf_advance(struct buffer *buf, ssize_t size)</span><br><s=
pan> {</span><br><span>@@ -625,11 +1163,18 @@</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Return a pointer to allocated space inside a buffer.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Return NULL if no space.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Reserve space at the end of a buffer for writ=
ing.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Increases \c buf-&gt;len by \=
c size and returns a pointer to the start of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * the newly reserved region.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param buf   The buffer to allocate space in.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of by=
tes to reserve.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to=
 the start of the reserved space, or NULL if there is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         insufficient capacity.</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static inline uint8_t *</span><br><span> buf_write_alloc(struct b=
uffer *buf, size_t size)</span><br><span> {</span><br><span>@@ -643,6 +1188=
,18 @@</span><br><span>     return ret;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Consume bytes from the front of=
 a buffer for reading.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns a p=
ointer to the current content start and advances the buffer</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * by \c size bytes.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param buf   The buffer to read from.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  Number of byte=
s to consume.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to t=
he start of the consumed region, or NULL if \c size</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         is negative or exceeds the cur=
rent length.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> static inline uint8_t *</span><br><span> buf_read_alloc(struc=
t buffer *buf, int size)</span><br><span> {</span><br><span>@@ -657,6 +1214=
,17 @@</span><br><span>     return ret;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Append data to a buffer.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Copies \c size bytes from \c src to th=
e end of \c dest.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Des=
tination buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param src   Data to append.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param size  Number of bytes to append.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true on success, false if there is insufficient=
 capacity.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span> static inline bool</span><br><span> buf_write(struct buffer *de=
st, const void *src, size_t size)</span><br><span> {</span><br><span>@@ -66=
9,6 +1237,18 @@</span><br><span>     return true;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Prepend data to a buf=
fer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Copies \c size bytes from \c =
src into the prepend space at the front of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * \c dest.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param dest  Destination buffer.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param src   Data to prepend.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param size  Number of bytes to prepend.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if ther=
e is insufficient prepend capacity.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span> static inline bool</span><br><span> bu=
f_write_prepend(struct buffer *dest, const void *src, int size)</span><br><=
span> {</span><br><span>@@ -681,12 +1261,28 @@</span><br><span>     return =
true;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Append a uint8_t to a buffer.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param dest  Destination buffer.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param data  Byte to append.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return true on success, false if there is insufficient ca=
pacity.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span> static inline bool</span><br><span> buf_write_u8(struct buffer *de=
st, uint8_t data)</span><br><span> {</span><br><span>     return buf_write(=
dest, &amp;data, sizeof(uint8_t));</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Append a uint16_t to a buffer in net=
work byte order.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Dest=
ination buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param data  Value to append (converted with \c htons()).</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return true on success, false if there is insuffici=
ent capacity.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> static inline bool</span><br><span> buf_write_u16(struct buf=
fer *dest, uint16_t data)</span><br><span> {</span><br><span>@@ -694,6 +129=
0,14 @@</span><br><span>     return buf_write(dest, &amp;u16, sizeof(uint16=
_t));</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Append a uint32_t to a buffer in network byte order.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param dest  Destination buffer.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param data  Value to append (=
converted with \c htonl()).</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n true on success, false if there is insufficient capacity.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline =
bool</span><br><span> buf_write_u32(struct buffer *dest, uint32_t data)</sp=
an><br><span> {</span><br><span>@@ -701,12 +1305,32 @@</span><br><span>    =
 return buf_write(dest, &amp;u32, sizeof(uint32_t));</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copy the content o=
f one buffer to the end of another.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param dest  Destination buffer.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param src   Source buffer.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return true on success, false if \c dest has insufficient capa=
city.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span> static inline bool</span><br><span> buf_copy(struct buffer *dest, co=
nst struct buffer *src)</span><br><span> {</span><br><span>     return buf_=
write(dest, BPTR(src), BLENZ(src));</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Read \c n bytes from \c src and app=
end them to \c dest.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Consumes the =
bytes from \c src.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  De=
stination buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param src   Source buffer (modified).</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param n     Number of bytes to copy.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true on success, false if \c src has few=
er than \c n bytes or</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *         \c dest has insufficient capacity.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</span><=
br><span> buf_copy_n(struct buffer *dest, struct buffer *src, int n)</span>=
<br><span> {</span><br><span>@@ -718,6 +1342,22 @@</span><br><span>     ret=
urn buf_write(dest, cp, n);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Copy a range of bytes from one buffer into =
a specific position in another.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Co=
pies \c src_len bytes starting at \c src_index within \c src content</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * into \c dest at \c dest=
_index relative to the content start.  Updates</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * \c dest-&gt;len if the write extends beyond t=
he current content.  Does not</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * advance either buffer&#39;s offset.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param dest        Destination buffer.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param dest_index  Byte offset within =
\c dest content to write at.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param src         Source buffer.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param src_index   Byte offset within \c src c=
ontent to read from.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param src_len     Number of bytes to copy.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return true on success, false if any index or length is out =
of range.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span> static inline bool</span><br><span> buf_copy_range(struct buffer=
 *dest, int dest_index, const struct buffer *src, int src_index,</span><br>=
<span>                int src_len)</span><br><span>@@ -735,7 +1375,19 @@</s=
pan><br><span>     return true;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/* truncate src to len, copy=
 excess data beyond len to dest */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Truncate \c src to \c len bytes and copy any excess to \c dest.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * If \c src-&gt;len &gt; \c len, \c src is tr=
uncated to \c len bytes and the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * remaining bytes are appended to \c dest.  If \c src-&gt;len =
&lt;=3D \c len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * n=
othing is copied and true is returned.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param dest  Destination buffer for the excess data.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param src   Source buffer to trun=
cate.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param len =
  Maximum number of bytes to keep in \c src.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return true on success, false if \c len is negative or copying =
fails.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> static inline bool</span><br><span> buf_copy_excess(struct buffer *=
dest, struct buffer *src, int len)</span><br><span> {</span><br><span>@@ -7=
59,6 +1411,17 @@</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Read bytes from the front of a =
buffer into a caller-supplied destination.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Consumes \c size bytes from \c src and copies them to \c dest.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param src   Source buffer (modified)=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  De=
stination memory.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param size  Number of bytes to read.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return true on success, false if \c src has fewer than \c size bytes.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
> static inline bool</span><br><span> buf_read(struct buffer *src, void *de=
st, int size)</span><br><span> {</span><br><span>@@ -771,6 +1434,14 @@</spa=
n><br><span>     return true;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Return the first byte of the buffer witho=
ut consuming it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The =
buffer to peek at.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The fir=
st byte as an unsigned value (0=E2=80=93255), or -1 if the buffer</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *         is empty.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static =
inline int</span><br><span> buf_peek_u8(struct buffer *buf)</span><br><span=
> {</span><br><span>@@ -783,6 +1454,13 @@</span><br><span>     return ret;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Read and consume a uint8_t from the front of a buffer.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param buf   The buffer to read from.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return The byte value (0=E2=80=93255), or -1 =
if the buffer is empty.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span> static inline int</span><br><span> buf_read_u8(str=
uct buffer *buf)</span><br><span> {</span><br><span>@@ -794,6 +1472,16 @@</=
span><br><span>     return ret;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Read and consume a uint16_t from the f=
ront of a buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The value is con=
verted from network byte order via \c ntohs().</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buf   The buffer to read from.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return The host-byte-order value, or -1 if the buffer has=
 fewer than 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
     bytes.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span> static inline int</span><br><span> buf_read_u16(struct buffer =
*buf)</span><br><span> {</span><br><span>@@ -805,6 +1493,17 @@</span><br><s=
pan>     return ntohs(ret);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Read and consume a uint32_t from the front =
of a buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The value is converte=
d from network byte order via \c ntohl().</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param buf   The buffer to read from.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param good  If non-NULL, set to true on succe=
ss or false on failure.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Th=
e host-byte-order value, or 0 if the buffer has fewer than 4</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *         bytes (check \c *good t=
o distinguish from a legitimate zero).</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span> static inline uint32_t</span><br><s=
pan> buf_read_u32(struct buffer *buf, bool *good)</span><br><span> {</span>=
<br><span>@@ -862,31 +1561,73 @@</span><br><span>     return memcmp(BPTR(sr=
c), match, size) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Return true if the head of \c src matches th=
e string \c match.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Compares the fi=
rst \c strlen(match) bytes of \c src content with \c match.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * *NOT* constant time. Do not use =
when comparing HMACs.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src  =
  Buffer whose head is compared.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param match  Null-terminated string to compare against.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true if the buffer starts wi=
th \c match.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> bool buf_string_match_head_str(const struct buffer *src, cons=
t char *match);</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Compare the head of \c src with \c match and advance past it if equal.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * If the buffer starts with \c match, t=
he matched bytes are consumed from</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * \c src.  *NOT* constant time. Do not use when comparing H=
MACs.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param src    Buffer to comp=
are and advance.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param match  Null-terminated string to compare against.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return true if the buffer started with \c match (an=
d was advanced).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span> bool buf_string_compare_advance(struct buffer *src, const=
 char *match);</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Return the length of the next token in a buffer up to a delimiter.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Scans the buffer content for \c delim and =
returns the number of bytes</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * up to (but not including) the delimiter, or the full buffer leng=
th if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the delimit=
er is not found.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf    The=
 buffer to scan.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param delim  Delimiter byte to search for.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return Number of bytes before the first occurrence of \c delim, =
or -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         if =
the buffer is empty.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span> int buf_substring_len(const struct buffer *buf, int d=
elim);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Print a strin=
g which might be NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a pr=
intable representation of a string that might be NULL.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param str   String to print, or NULL.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return \c str if non-NULL, otherwise the string =
\c &quot;[NULL]&quot;.</span><br><span>  */</span><br><span> const char *np=
(const char *str);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/* character classes */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
* @name Character classes</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  @brief Check or modify strings based on classes of allowed</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *         or forbidden ch=
aracters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><span> #=
define CC_ANY  (1 &lt;&lt; 0)           /**&lt; any character */</span><br>=
<span> #define CC_NULL (1 &lt;&lt; 1)           /**&lt; null character \0 *=
/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine CC_ALNUM  (1 &lt;&lt; 2)         /**&lt; alphanumeric isalnum() */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_ALPHA  (1 &lt=
;&lt; 3)         /**&lt; alphabetic isalpha() */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CC_ALNUM  (1 &lt;&lt; 2)         /**&l=
t; alphanumeric \c isalnum() */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CC_ALPHA  (1 &lt;&lt; 3)         /**&lt; alphabetic \c =
isalpha() */</span><br><span> #define CC_ASCII  (1 &lt;&lt; 4)         /**&=
lt; ASCII character */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define CC_CNTRL  (1 &lt;&lt; 5)         /**&lt; control character iscntrl=
() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_DIGIT=
  (1 &lt;&lt; 6)         /**&lt; digit isdigit() */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CC_CNTRL  (1 &lt;&lt; 5)         =
/**&lt; control character \c iscntrl() */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CC_DIGIT  (1 &lt;&lt; 6)         /**&lt; digi=
t \c isdigit() */</span><br><span> #define CC_PRINT  (1 &lt;&lt; 7)        =
 /**&lt; printable (&gt;=3D 32, !=3D 127) */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define CC_PUNCT  (1 &lt;&lt; 8)         /**&lt; pun=
ctuation ispunct() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define CC_SPACE  (1 &lt;&lt; 9)         /**&lt; whitespace isspace() */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_XDIGIT (1 &lt=
;&lt; 10)        /**&lt; hex digit isxdigit() */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CC_PUNCT  (1 &lt;&lt; 8)         /**&l=
t; punctuation \c ispunct() */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define CC_SPACE  (1 &lt;&lt; 9)         /**&lt; whitespace \c i=
sspace() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
CC_XDIGIT (1 &lt;&lt; 10)        /**&lt; hex digit \c isxdigit() */</span><=
br><span> </span><br><span> #define CC_BLANK   (1 &lt;&lt; 11)       /**&lt=
; space or tab */</span><br><span> #define CC_NEWLINE (1 &lt;&lt; 12)      =
 /**&lt; newline */</span><br><span>@@ -914,8 +1655,27 @@</span><br><span> =
#define CC_NAME (CC_ALNUM | CC_UNDERBAR) /**&lt; alphanumeric plus undersco=
re */</span><br><span> #define CC_CRLF (CC_CR | CC_NEWLINE)     /**&lt; car=
riage return or newline */</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Test whether a character belongs to one or more character class=
es.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param c      The character to=
 test.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param fla=
gs  Bitmask of \c CC_* character class flags.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return true if \c c matches any of the classes specified in \c=
 flags.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span> bool char_class(const unsigned char c, const unsigned int flags);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Test whether al=
l characters in a string satisfy a character class filter.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param str        The null-terminated string to te=
st.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param inclus=
ive  Classes that are permitted (characters must match at</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *                   least one of the=
se).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param exclu=
sive  Classes that are forbidden (characters must not match</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *                   any of these, =
even if they also match \c inclusive).</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return true if every character in \c str is permitted.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool string_c=
lass(const char *str, const unsigned int inclusive, const unsigned int excl=
usive);</span><br><span> </span><br><span> /**</span><br><span>@@ -962,10 +=
1722,27 @@</span><br><span>  */</span><br><span> const char *string_mod_con=
st(const char *str, const unsigned int inclusive,</span><br><span>         =
                     const unsigned int exclusive, const char replace, stru=
ct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*@}*/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Replace a=
ll leading occurrences of a character in a string.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Scans from the start of \c str and replaces every consecut=
ive \c match</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * char=
acter with \c replace, stopping at the first character that does not</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * match.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param str      The null-terminated string to modi=
fy in place.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am match    The character to replace.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param replace  The replacement character.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void strin=
g_replace_leading(char *str, const char match, const char replace);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Return =
true iff str starts with prefix */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Return true iff \c str starts with \c prefix.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param str     The string to test.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param prefix  The prefix to look for.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> sta=
tic inline bool</span><br><span> strprefix(const char *str, const char *pre=
fix)</span><br><span> {</span><br><span>@@ -1000,6 +1777,16 @@</span><br><s=
pan>  * Verify that a pointer is correctly aligned</span><br><span>  */</sp=
an><br><span> #ifdef VERIFY_ALIGNMENT</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Assert that the content pointer of \c buf is 4-byte aligned.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Only compiled in when \c VERIFY_ALIGNMENT i=
s defined.  Called via the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * \c verify_align_4() macro.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param buf   Buffer whose content pointer is to be checked.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param file  Source file of t=
he call site (for the error message).</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param line  Source line of the call site (for the err=
or message).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> void valign4(const struct buffer *buf, const char *file, cons=
t int line);</span><br><span> </span><br><span> #define verify_align_4(ptr)=
 valign4(buf, __FILE__, __LINE__)</span><br><span>@@ -1007,23 +1794,58 @@</=
span><br><span> #define verify_align_4(ptr)</span><br><span> #endif</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Very basic garbage collecti=
on, mostly for routines that return</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * char ptrs to malloced strings.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/** @name Garbage Collection</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  @brief Basic garbage collection, m=
ostly for routines that return</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *         char ptrs to malloced strings.</span><br><span>  */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@{*/</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Move all allocations from on=
e garbage collection arena to another.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * After the call \c src is empty and all entries previously in \c src ar=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * owned by \c des=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param dest  Arena to move allo=
cations into.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram src   Arena to move allocations from (emptied on return).</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void gc_tran=
sfer(struct gc_arena *dest, struct gc_arena *src);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Free all plain allocations in a garbag=
e collection arena.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Internal imple=
mentation called by \c gc_free().  Do not call directly.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param a  The arena whose \c list entries are to be =
freed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span> void x_gc_free(struct gc_arena *a);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Free all specially-allocated entries in a garb=
age collection arena.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Internal imp=
lementation called by \c gc_free().  Do not call directly.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Invokes the custom free function =
stored in each \c gc_entry_special.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param a  The arena whose \c list_special entries are to be freed.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void =
x_gc_freespecial(struct gc_arena *a);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Return true iff the arena contains at least one allo=
cation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena to tes=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an> static inline bool</span><br><span> gc_defined(struct gc_arena *a)</spa=
n><br><span> {</span><br><span>     return a-&gt;list !=3D NULL;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initia=
lise a garbage collection arena to an empty state.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param a  The arena to initialise.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</=
span><br><span> gc_init(struct gc_arena *a)</span><br><span> {</span><br><s=
pan>@@ -1031,12 +1853,25 @@</span><br><span>     a-&gt;list_special =3D NUL=
L;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Detach all allocations from an arena without freeing them.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * After this call the arena is empty.  The ca=
ller takes responsibility for</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * freeing the previously registered allocations.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param a  The arena to detach.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline voi=
d</span><br><span> gc_detach(struct gc_arena *a)</span><br><span> {</span><=
br><span>     gc_init(a);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Allocate and return a new, empty garbage coll=
ection arena.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return An initialis=
ed \c gc_arena with empty lists.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> static inline struct gc_arena</span><br><=
span> gc_new(void)</span><br><span> {</span><br><span>@@ -1045,6 +1880,14 @=
@</span><br><span>     return ret;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Free all allocations in a garbage co=
llection arena.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calls \c x_gc_free=
() and \c x_gc_freespecial() as needed to release all</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * registered memory.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param a  The arena to free.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</spa=
n><br><span> gc_free(struct gc_arena *a)</span><br><span> {</span><br><span=
>@@ -1058,6 +1901,13 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free all allocations in =
a garbage collection arena and reinitialise it.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Equivalent to calling \c gc_free() followed by \c gc_init().<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param a  The arena to reset.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> sta=
tic inline void</span><br><span> gc_reset(struct gc_arena *a)</span><br><sp=
an> {</span><br><span>@@ -1075,58 +1925,139 @@</span><br><span> /* 1 GB on =
32bit systems, they usually can only allocate 2 GB for the</span><br><span>=
  * whole process.</span><br><span>  */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** Maximum size for a single array allocation (checked=
 by \c array_mult_safe()). */</span><br><span> #define ALLOC_SIZE_MAX (1u &=
lt;&lt; 30)</span><br><span> #else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/** Maximum size for a single array allocation (checked by \=
c array_mult_safe()). */</span><br><span> #define ALLOC_SIZE_MAX ((size_t)1=
 &lt;&lt; 32) /* 4 GB */</span><br><span> #endif</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Allocate memory for a single object of th=
e given type.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calls \c check_mallo=
c_return() to abort on allocation failure.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param dptr  Pointer variable that receives the allocation.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type  Type of th=
e object to allocate.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span> #define ALLOC_OBJ(dptr, type)                       =
                \</span><br><span>     {                                   =
                            \</span><br><span>         check_malloc_return(=
(dptr) =3D (type *)malloc(sizeof(type))); \</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-initi=
alise memory for a single object of the given type.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param dptr  Pointer variable that receives the allocat=
ion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type =
 Type of the object to allocate.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span> #define ALLOC_OBJ_CLEAR(dptr, type)      =
\</span><br><span>     {                                    \</span><br><sp=
an>         ALLOC_OBJ(dptr, type);           \</span><br><span>         mem=
set((dptr), 0, sizeof(type)); \</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Allocate memory for an array of \c =
n elements of the given type.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Uses=
 \c array_mult_safe() to guard against size overflow.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Calls \c check_malloc_return() to abor=
t on allocation failure.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dp=
tr  Pointer variable that receives the allocation.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param type  Element type of the array.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n     Numbe=
r of elements.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span> #define ALLOC_ARRAY(dptr, type, n)                         =
                                  \</span><br><span>     {                 =
                                                                       \</s=
pan><br><span>         check_malloc_return((dptr) =3D (type *)malloc(array_=
mult_safe(sizeof(type), (n), 0))); \</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a garbage-collected a=
rray of \c n elements of the given type.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param dptr  Pointer variable that receives the allocation.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type  Element type=
 of the array.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram n     Number of elements.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param gc    Garbage collection arena to register the allocat=
ion with.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span> #define ALLOC_ARRAY_GC(dptr, type, n, gc)                       =
                        \</span><br><span>     {                           =
                                                        \</span><br><span> =
        (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(type), (n), 0),=
 false, (gc)); \</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Allocate and zero-initialise an array of \c n elem=
ents of the given type.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dpt=
r  Pointer variable that receives the allocation.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param type  Element type of the array.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n     Number=
 of elements.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> #define ALLOC_ARRAY_CLEAR(dptr, type, n)                    =
        \</span><br><span>     {                                           =
                    \</span><br><span>         ALLOC_ARRAY(dptr, type, n); =
                                \</span><br><span>         memset((dptr), 0=
, (array_mult_safe(sizeof(type), (n), 0))); \</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-ini=
tialise a garbage-collected array of \c n elements.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param dptr  Pointer variable that receives the allocat=
ion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type =
 Element type of the array.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param n     Number of elements.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param gc    Garbage collection arena to registe=
r the allocation with.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span> #define ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc)    =
                                    \</span><br><span>     {               =
                                                                   \</span>=
<br><span>         (dptr) =3D (type *)gc_malloc(array_mult_safe(sizeof(type=
), (n), 0), true, (gc)); \</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Allocate and zero-initialise a garbage=
-collected variable-length structure.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Allocates \c sizeof(type) + \c n * \c sizeof(atype) bytes for a structu=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that embeds a =
variable-length array of \c atype as its last member.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param dptr   Pointer variable that receives the alloca=
tion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type=
   Type of the enclosing structure.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param atype  Element type of the variable-length array =
member.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n =
     Number of array elements.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param gc     Garbage collection arena to register the alloca=
tion with.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span> #define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, atype, n, gc)     =
                                    \</span><br><span>     {               =
                                                                           =
    \</span><br><span>         (dptr) =3D (type *)gc_malloc(array_mult_safe=
(sizeof(atype), (n), sizeof(type)), true, (gc)); \</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate a garba=
ge-collected object of the given type (uninitialised).</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param dptr  Pointer variable that receives the alloca=
tion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type=
  Type of the object to allocate.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param gc    Garbage collection arena to register the allo=
cation with.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span> #define ALLOC_OBJ_GC(dptr, type, gc)                         =
  \</span><br><span>     {                                                 =
         \</span><br><span>         (dptr) =3D (type *)gc_malloc(sizeof(typ=
e), false, (gc)); \</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Allocate and zero-initialise a garbage-collecte=
d object of the given type.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 dptr  Pointer variable that receives the allocation.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param type  Type of the object to all=
ocate.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc =
   Garbage collection arena to register the allocation with.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> #define ALLOC=
_OBJ_CLEAR_GC(dptr, type, gc)                    \</span><br><span>     {  =
                                                       \</span><br><span>  =
       (dptr) =3D (type *)gc_malloc(sizeof(type), true, (gc)); \</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ab=
ort if a memory allocation returned NULL.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param p  Return value from \c malloc() or similar; calls \c out_of=
_memory()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
   if \c p is NULL.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span> static inline void</span><br><span> check_malloc_retur=
n(void *p)</span><br><span> {</span><br><span>@@ -1135,22 +2066,28 @@</span=
><br><span>         out_of_memory();</span><br><span>     }</span><br><span=
> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**@}*/</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* End of GC */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Manage lists of buffers</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/** @name Buffer Lists</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @brief Manage lists o=
f buffers</span><br><span>  */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**@{*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** One node in a \c=
 buffer_list linked list. */</span><br><span> struct buffer_entry</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct b=
uffer buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
buffer_entry *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf;         /**&lt; The buffer stored in this list node.=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r_entry *next; /**&lt; Pointer to the next node, or NULL. */</span><br><spa=
n> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/** A singly-linked list of buffers, with head/tail pointers for O(1) p=
ush. */</span><br><span> struct buffer_list</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct buffer_entry *head; /* =
next item to pop/peek */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct buffer_entry *tail; /* last item pushed */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int size;                  /* curren=
t number of entries */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int max_size;              /* maximum size list should grow to */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer_entry =
*head; /**&lt; Next item to pop/peek. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer_entry *tail; /**&lt; Last item pushe=
d. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int size; =
                 /**&lt; Current number of entries. */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int max_size;              /**&lt; M=
aximum number of entries allowed. */</span><br><span> };</span><br><span> <=
/span><br><span> /**</span><br><span>@@ -1211,8 +2148,24 @@</span><br><span=
>  */</span><br><span> struct buffer *buffer_list_peek(struct buffer_list *=
ol);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Advance pa=
st \c n bytes in the head buffer, popping it if it becomes empty.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * \c n must not exceed the length of the head=
 buffer; passing a larger value</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * triggers an assertion failure.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param ol  The list whose head buffer is to be advanced.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n   Number of by=
tes to skip in the head buffer.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> void buffer_list_advance(struct buffer_lis=
t *ol, ssize_t n);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Remove and free the head buffer of the list.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Does nothing if \c ol is NULL or empty.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param ol  The list to pop from.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void buffer_list_pop=
(struct buffer_list *ol);</span><br><span> </span><br><span> /**</span><br>=
<span>@@ -1240,6 +2193,20 @@</span><br><span>  */</span><br><span> void buf=
fer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len, =
const char *sep);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Read a file into a buffer list, one buffer per line.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Opens \c fn for reading and pushes each line into a n=
ewly allocated buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * list using \c fgets().  Lines longer than \c max_line_len - 1 bytes ar=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * split across mu=
ltiple consecutive buffers.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 fn            Path to the file to read.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param max_line_len  Maximum number of bytes (inclu=
ding null terminator)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                      read per \c fgets() call.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return Pointer to the new buffer list, or NULL if the =
file could not be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
         opened or memory allocation failed.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span> struct buffer_list *buffer_li=
st_file(const char *fn, int max_line_len);</span><br><span> </span><br><spa=
n> /**</span><br><span>@@ -1253,5 +2220,7 @@</span><br><span>  * error</spa=
n><br><span>  */</span><br><span> struct buffer buffer_read_from_file(const=
 char *filename, struct gc_arena *gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**@}*/</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* End of Buffer Lists */</span><br><span> </span><br><span> #endif =
/* BUFFER_H */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1581?usp=3Demail">change 1581</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1581?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I350ca5b08379ede1480b81055d3=
5dd9a33e30cff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1581 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--YNoDRP2CEbE=--

