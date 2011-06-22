From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 22 Jun 2011 08:51:34 +0200
Message-ID: <1308725496-10620-7-git-send-email-dejong@...1435...>
In-Reply-To: <1308725496-10620-1-git-send-email-dejong@...1435...>
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/8] Added memory management documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 buffer.h                |   57 +++++++++++++++++++++++----
 doc_memory_management.h |   99 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 9 deletions(-)
 create mode 100644 doc_memory_management.h

diff --git a/buffer.h b/buffer.h
index 1fe3c08..06d5e84 100644
--- a/buffer.h
+++ b/buffer.h
@@ -42,14 +42,30 @@
 #define BUF_INIT_TRACKING
 #endif
 
-/* basic buffer class for OpenVPN */
-
+/**************************************************************************/
+/**
+ * Wrapper structure for dynamically allocated memory.
+ * 
+ * The actual content stored in a \c buffer structure starts at the memory
+ * location \c buffer.data \c + \c buffer.offset, and has a length of \c
+ * buffer.len bytes.  This, together with the space available before and
+ * after the content, is represented in the pseudocode below:
+@code
+uint8_t *content_start    = buffer.data + buffer.offset;
+uint8_t *content_end      = buffer.data + buffer.offset + buffer.len;
+int      prepend_capacity = buffer.offset;
+int      append_capacity  = buffer.capacity - (buffer.offset + buffer.len);
+@endcode
+ */
 struct buffer
 {
-  int capacity;	   /* size of buffer allocated by malloc */
-  int offset;	   /* data starts at data + offset, offset > 0 to allow for efficient prepending */
-  int len;	   /* length of data that starts at data + offset */
-  uint8_t *data;
+  int capacity;                 /**< Size in bytes of memory allocated by
+                                 *   \c malloc(). */
+  int offset;                   /**< Offset in bytes of the actual content
+                                 *   within the allocated memory. */
+  int len;                      /**< Length in bytes of the actual content
+                                 *   within the allocated memory. */
+  uint8_t *data;                /**< Pointer to the allocated memory. */
 
 #ifdef BUF_INIT_TRACKING
   const char *debug_file;
@@ -57,18 +73,41 @@ struct buffer
 #endif
 };
 
-/* for garbage collection */
 
+/**************************************************************************/
+/**
+ * Garbage collection entry for one dynamically allocated block of memory.
+ * 
+ * This structure represents one link in the linked list contained in a \c
+ * gc_arena structure.  Each time the \c gc_malloc() function is called,
+ * it allocates \c sizeof(gc_entry) + the requested number of bytes.  The
+ * \c gc_entry is then stored as a header in front of the memory address
+ * returned to the caller.
+ */
 struct gc_entry
 {
-  struct gc_entry *next;
+  struct gc_entry *next;        /**< Pointer to the next item in the
+                                 *   linked list. */
 };
 
+
+/**
+ * Garbage collection arena used to keep track of dynamically allocated
+ * memory.
+ * 
+ * This structure contains a linked list of \c gc_entry structures.  When
+ * a block of memory is allocated using the \c gc_malloc() function, the
+ * allocation is registered in the function's \c gc_arena argument.  All
+ * the dynamically allocated memory registered in a \c gc_arena can be
+ * freed using the \c gc_free() function.
+ */
 struct gc_arena
 {
-  struct gc_entry *list;
+  struct gc_entry *list;        /**< First element of the linked list of
+                                 *   \c gc_entry structures. */
 };
 
+
 #define BPTR(buf)  (buf_bptr(buf))
 #define BEND(buf)  (buf_bend(buf))
 #define BLAST(buf) (buf_blast(buf))
diff --git a/doc_memory_management.h b/doc_memory_management.h
new file mode 100644
index 0000000..4549498
--- /dev/null
+++ b/doc_memory_management.h
@@ -0,0 +1,99 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * Memory management strategies documentation file.
+ */
+
+/**
+ * @page memory_management OpenVPN's memory management strategies
+ * 
+ * This section describes several implementation details relating to
+ * OpenVPN's memory management strategies.
+ * 
+ * During operation, the OpenVPN process performs all kinds of operations
+ * on blocks of data.  Receiving packets, encrypting content, prepending
+ * headers, etc.  To make the programmer's job easier and to decrease the
+ * likelihood of memory-related bugs, OpenVPN uses its own memory %buffer
+ * library and garbage collection facilities.  These are described in
+ * brief here.
+ * 
+ * @section memory_management_buffer The buffer structure
+ * 
+ * The \c buffer structure is a wrapper around a block of dynamically
+ * allocated memory which keeps track of the block's capacity \c
+ * buffer.capacity and location in memory \c buffer.data.  This structure
+ * supports efficient prepending and appending within the allocated memory
+ * through the use of offset \c buffer.offset and length \c buffer.len
+ * fields.  See the \c buffer documentation for more details on the
+ * structure itself.
+ * 
+ * OpenVPN's %buffer library, implemented in the \c buffer.h and \c
+ * buffer.c files, contains many utility functions for working with \c
+ * buffer structures.  These functions facilitate common operations, such
+ * as allocating, freeing, reading and writing to \c buffer structures,
+ * and even offer several more advanced operations, such as string
+ * matching and creating sub-buffers.
+ * 
+ * Not only do these utility functions make working with \c buffer
+ * structures easy, they also perform extensive error checking.  Each
+ * function, where necessary, checks whether enough space is available
+ * before performing its actions.  This minimizes the chance of bugs
+ * leading to %buffer overflows and other vulnerabilities.
+ * 
+ * @section memory_management_frame The frame structure
+ * 
+ * The \c frame structure keeps track of the maximum allowed packet
+ * geometries of a network connection.
+ * 
+ * It is used, for example, to determine the size of \c buffer structures
+ * in which to store data channel packets.  This is done by having each
+ * data channel processing module register the maximum amount of extra
+ * space it will need for header prepending and content expansion in the
+ * \c frame structure. Once these parameters are known, \c buffer
+ * structures can be allocated, based on the \c frame parameters, so that
+ * they are large enough to allow efficient prepending of headers and
+ * processing of content.
+ * 
+ * @section memory_management_garbage Garbage collection
+ * 
+ * OpenVPN has many sizable functions which perform various actions
+ * depending on their %context.  This makes it difficult to know in advance
+ * exactly how much memory must be allocated.  The garbage collection
+ * facilities are used to keep track of dynamic allocations, thereby
+ * allowing easy collective freeing of the allocated memory.
+ * 
+ * The garbage collection system is implemented by the \c gc_arena and \c
+ * gc_entry structures.  The arena represents a garbage collecting unit,
+ * and contains a linked list of entries.  Each entry represents one block
+ * of dynamically allocated memory.
+ * 
+ * The garbage collection system also contains various utility functions
+ * for working with the garbage collection structures.  These include
+ * functions for initializing new arenas, allocating memory of a given
+ * size and registering the allocation in an arena, and freeing all the
+ * allocated memory associated with an arena.
+ */
-- 
1.7.4.1


