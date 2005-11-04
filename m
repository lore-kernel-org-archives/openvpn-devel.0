Message-ID: <436B4299.2040608@...488...>
From: "M. van Cuijk" <mark@...488...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Byte counting bug
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Nov  4 03:15:41 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I just discovered a problem with the byte counting code in OpenVPN.
The counter_type is declared as 'unsigned long', allowing it to count up 
to 4 GB.
However, when calling the client_disconnect script, the value is 
converted to an int through setenv_int(), which may result in negative 
values to be passed to the script. I noticed this because we were about 
to bill a customer with negative charges.

Appended to this post is a patch that adds a setenv_counter() function 
to make the correct conversion. It also patches a similar bug in occ.c 
and it changes the counter_type to allow values above 4 GB.

- Mark


diff -Naur openvpn-2.0.5.orig/common.h openvpn-2.0.5/common.h
--- openvpn-2.0.5.orig/common.h 2005-11-01 12:06:11.000000000 +0100
+++ openvpn-2.0.5/common.h      2005-11-04 11:45:57.642880993 +0100
@@ -28,7 +28,7 @@
/*
 * Statistics counters.
 */
-typedef unsigned long counter_type;
+typedef unsigned long long int counter_type;

/*
 * Time intervals
@@ -43,7 +43,7 @@
/*
 * Printf formats for special types
 */
-#define counter_format          "%lu"
+#define counter_format          "%llu"
#define ptr_format              "0x%08lx"
#define time_format             "%lu"
#define fragment_header_format  "0x%08x"
diff -Naur openvpn-2.0.5.orig/misc.c openvpn-2.0.5/misc.c
--- openvpn-2.0.5.orig/misc.c   2005-11-01 12:06:11.000000000 +0100
+++ openvpn-2.0.5/misc.c        2005-11-04 11:51:40.071418083 +0100
@@ -843,6 +843,14 @@
/* add/modify/delete environmental strings */

void
+setenv_counter (struct env_set *es, const char *name, counter_type value)
+{
+  char buf[64];
+  openvpn_snprintf (buf, sizeof(buf), counter_format, value);
+  setenv_str (es, name, buf);
+}
+
+void
setenv_int (struct env_set *es, const char *name, int value)
{
  char buf[64];
diff -Naur openvpn-2.0.5.orig/misc.h openvpn-2.0.5/misc.h
--- openvpn-2.0.5.orig/misc.h   2005-11-01 12:06:11.000000000 +0100
+++ openvpn-2.0.5/misc.h        2005-11-04 11:50:53.715176112 +0100
@@ -158,6 +158,7 @@
                   const unsigned int value_exclude,
                   const char value_replace);

+void setenv_counter (struct env_set *es, const char *name, counter_type 
value);
void setenv_int (struct env_set *es, const char *name, int value);
void setenv_str (struct env_set *es, const char *name, const char *value);
void setenv_del (struct env_set *es, const char *name);
diff -Naur openvpn-2.0.5.orig/multi.c openvpn-2.0.5/multi.c
--- openvpn-2.0.5.orig/multi.c  2005-11-01 19:21:15.000000000 +0100
+++ openvpn-2.0.5/multi.c       2005-11-04 11:50:04.606572638 +0100
@@ -396,8 +396,8 @@
  setenv_trusted (mi->context.c2.es, get_link_socket_info (&mi->context));

  /* setenv stats */
-  setenv_int (mi->context.c2.es, "bytes_received", 
mi->context.c2.link_read_bytes);
-  setenv_int (mi->context.c2.es, "bytes_sent", 
mi->context.c2.link_write_bytes);
+  setenv_counter (mi->context.c2.es, "bytes_received", 
mi->context.c2.link_read_bytes);
+  setenv_counter (mi->context.c2.es, "bytes_sent", 
mi->context.c2.link_write_bytes);

}

diff -Naur openvpn-2.0.5.orig/occ.c openvpn-2.0.5/occ.c
--- openvpn-2.0.5.orig/occ.c    2005-11-01 12:06:11.000000000 +0100
+++ openvpn-2.0.5/occ.c 2005-11-04 11:47:35.477179182 +0100
@@ -165,9 +165,9 @@
            PACKAGE_NAME
            " before 1.5-beta8 or if there is a network connectivity 
problem, and will not necessarily prevent "
            PACKAGE_NAME
-            " from running (%u bytes received from peer, %u bytes 
authenticated data channel traffic) -- you can disable the options 
consistency check with --disable-occ.",
-            (unsigned int) c->c2.link_read_bytes,
-            (unsigned int) c->c2.link_read_bytes_auth);
+            " from running (" counter_format " bytes received from 
peer, " counter_format " bytes authenticated data channel traffic) -- 
you can disable the options consistency check with --disable-occ.",
+            c->c2.link_read_bytes,
+            c->c2.link_read_bytes_auth);
      event_timeout_clear (&c->c2.occ_interval);
    }
  else


