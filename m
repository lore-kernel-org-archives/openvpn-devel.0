Message-ID: <4D40B3B9.9070208@...1194...>
Date: Wed, 26 Jan 2011 15:52:25 -0800
From: Roman Vasilyev <roman@...1194...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060405020906010709020002"
Subject: [Openvpn-devel] FreeBSD kqueue patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--------------060405020906010709020002
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've made patch for kqueue FreeBSD support, could somebody review it?



--------------060405020906010709020002
Content-Type: text/x-patch; name="kqueue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kqueue.patch"

diff -Naur openvpn-2.1.4/event.c openvpn-2.1.4.new/event.c
--- openvpn-2.1.4/event.c	2010-10-21 10:37:51.000000000 -0700
+++ openvpn-2.1.4.new/event.c	2011-01-26 15:11:06.000000000 -0800
@@ -30,6 +30,10 @@
 #include "event.h"
 
 #include "memdbg.h"
+#define KQUEUE 1
+#if KQUEUE
+#include <sys/event.h>
+#endif
 
 /*
  * Some OSes will prefer select() over poll()
@@ -599,7 +603,163 @@
 
   return (struct event_set *) eps;
 }
-#endif /* EPOLL */
+
+#elif KQUEUE /* EPOLL */
+
+struct kq_set
+{
+  struct event_set_functions func;
+  bool fast;
+  int kqfd;
+  int maxevents;
+  struct kevent *changes;
+  size_t changes_size;
+  size_t maxchanges;
+  struct kevent *events;
+};
+
+static void
+kq_free (struct event_set *es)
+{
+  struct kq_set *kqs = (struct kq_set *) es;
+  close (kqs->kqfd);
+  free (kqs->changes);
+  free (kqs->events);
+  free (kqs);
+}
+
+static void
+kq_reset (struct event_set *es)
+{
+  const struct kq_set *kqs = (struct kq_set *) es;
+  ASSERT (kqs->fast);
+}
+
+static void
+kq_del (struct event_set *es, event_t event)
+{
+  struct kq_set *kqs = (struct kq_set *) es;
+  struct kevent *ev;
+
+  dmsg (D_EVENT_WAIT, "KQ_DEL ev=%d", (int)event);
+
+  ASSERT (!kqs->fast);
+  if ( kqs->changes_size+2 > kqs->maxchanges) {
+    kqs->maxchanges+=128;
+    kqs->changes = realloc(kqs->changes, sizeof(struct kevent)*kqs->maxchanges);
+  }
+
+  ev=&kqs->changes[kqs->changes_size++];
+  ev->ident = event;
+  ev->flags = EV_DELETE;
+  ev->filter = EVFILT_READ;
+
+  ev=&kqs->changes[kqs->changes_size++];
+  ev->ident = event;
+  ev->flags = EV_DELETE;
+  ev->filter = EVFILT_WRITE;
+}
+
+static void
+kq_ctl (struct event_set *es, event_t event, unsigned int rwflags, void *arg)
+{
+  struct kq_set *kqs = (struct kq_set *) es;
+  if ( kqs->changes_size+2 > kqs->maxchanges) {
+    kqs->maxchanges+=128;
+    kqs->changes = realloc(kqs->changes, sizeof(struct kevent)*kqs->maxchanges);
+  }
+
+  if (rwflags & EVENT_READ) {
+    struct kevent *ev=&kqs->changes[kqs->changes_size++];
+    ev->udata=arg;
+    ev->ident = event;
+    ev->flags = EV_ADD;
+    ev->filter = EVFILT_READ;
+  }
+  if (rwflags & EVENT_WRITE) {
+    struct kevent *ev=&kqs->changes[kqs->changes_size++];
+    ev->udata=arg;
+    ev->ident = event;
+    ev->flags = EV_ADD;
+    ev->filter = EVFILT_WRITE;
+  }
+}
+
+static int
+kq_wait (struct event_set *es, const struct timeval *tv, struct event_set_return *out, int outlen)
+{
+  struct kq_set *kqs = (struct kq_set *) es;
+  int stat;
+  struct timespec ts;
+  TIMEVAL_TO_TIMESPEC(tv, &ts);
+
+  if (outlen > kqs->maxevents) {
+    kqs->maxevents=outlen;
+    kqs->events = realloc(kqs->events, sizeof(struct kevent)*outlen);
+  }
+
+  stat = kevent (kqs->kqfd, kqs->changes, kqs->changes_size, kqs->events, outlen, &ts );
+  kqs->changes_size=0;
+
+  if (stat > 0)
+    {
+      int i;
+      const struct kevent *ev = kqs->events;
+      struct event_set_return *esr = out;
+      for (i = 0; i < stat; ++i)
+	{
+	  esr->rwflags = 0;
+	  if (ev->filter == EVFILT_READ)
+	    esr->rwflags |= EVENT_READ;
+	  if (ev->filter == EVFILT_WRITE)
+	    esr->rwflags |= EVENT_WRITE;
+	  esr->arg = ev->udata;
+	  dmsg (D_EVENT_WAIT, "KQ_WAIT[%d] rwflags=0x%04x ev=0x%08x arg=" ptr_format,
+	       i, esr->rwflags, ev->flags, (ptr_type)ev->udata);
+	  ++ev;
+	  ++esr;
+	}
+    }
+  return stat;
+}
+
+static struct event_set *
+kq_init (int *maxevents, unsigned int flags)
+{
+  struct kq_set *kqs;
+  int fd;
+
+  dmsg (D_EVENT_WAIT, "KQ_INIT maxevents=%d flags=0x%08x", *maxevents, flags);
+
+  /* open epoll file descriptor */
+  fd = kqueue ();
+  if (fd < 0)
+    return NULL;
+
+  ALLOC_OBJ_CLEAR (kqs, struct kq_set);
+
+  /* set dispatch functions */
+  kqs->func.free = kq_free;
+  kqs->func.reset = kq_reset;
+  kqs->func.del = kq_del;
+  kqs->func.ctl = kq_ctl;
+  kqs->func.wait = kq_wait;
+
+  /* fast method ("sort of") corresponds to epoll one-shot */
+  if (flags & EVENT_METHOD_FAST)
+    kqs->fast = true;
+
+  /* allocate space for epoll_wait return */
+  ASSERT (*maxevents > 0);
+  kqs->maxevents = *maxevents;
+  ALLOC_ARRAY_CLEAR (kqs->events, struct kevent, kqs->maxevents);
+
+  /* set epoll control fd */
+  kqs->kqfd = fd;
+
+  return (struct event_set *) kqs;
+}
+#endif
 
 #if POLL
 
@@ -1005,6 +1165,10 @@
   if (flags & EVENT_METHOD_US_TIMEOUT)
     ret = se_init (maxevents, flags); 
 #endif
+# ifdef KQUEUE
+   if (!ret)
+     ret = kq_init (maxevents, flags);
+# endif
 # ifdef SELECT_PREFERRED_OVER_POLL
    if (!ret)
      ret = se_init (maxevents, flags);
@@ -1038,6 +1202,13 @@
       msg (M_WARN, "Note: sys_epoll API is unavailable, falling back to poll/select API");
       ret = event_set_init_simple (maxevents, flags);
     }
+#elif KQUEUE
+  ret = kq_init (maxevents, flags);
+  if (!ret)
+    {
+      msg (M_WARN, "Note: sys_epoll API is unavailable, falling back to poll/select API");
+      ret = event_set_init_simple (maxevents, flags);
+    }
 #else
   ret = event_set_init_simple (maxevents, flags);
 #endif

--------------060405020906010709020002--

