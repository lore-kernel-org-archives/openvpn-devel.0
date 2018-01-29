MIME-Version: 1.0
From: Martin T <m4rtntns@...277...>
Date: Mon, 29 Jan 2018 13:30:59 +0200
Message-ID: <CAJx5YvH_iw_+NHqKzvQax70RpXfzvRSV-pZC2BaV5auKGKN3fQ@...278...>
Subject: [Openvpn-devel] patch for openvpn-auth-pam plugin to pass PAM_RHOST
 variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi!

Currently openvpn-auth-pam plugin does not set PAM_RHOST(requesting
host) variable. This is needed when for example pam_access.so plugin
is used and based on OpenVPN client network, different authentication
methods are desired. Proof of concept patch for PAM_RHOST is
following:

--- /var/tmp/auth-pam.c.orig 2018-01-24 21:26:06.262178266 +0200
+++ auth-pam.c 2018-01-25 01:23:14.669019911 +0200
@@ -110,6 +110,8 @@

     char username[128];
     char password[128];
+    char untrusted_ip[128];
+    char untrusted_ip6[128];
     char common_name[128];

     const struct name_value_list *name_value_list;
@@ -451,6 +453,8 @@
         /* get username/password from envp string array */
         const char *username = get_env("username", envp);
         const char *password = get_env("password", envp);
+        const char *untrusted_ip = get_env ("untrusted_ip", envp) ?
get_env("untrusted_ip", envp) : "";
+        const char *untrusted_ip6 = get_env ("untrusted_ip6", envp) ?
get_env("untrusted_ip6", envp) : "";
         const char *common_name = get_env("common_name", envp) ?
get_env("common_name", envp) : "";

         if (username && strlen(username) > 0 && password)
@@ -458,6 +462,8 @@
             if (send_control(context->foreground_fd, COMMAND_VERIFY) == -1
                 || send_string(context->foreground_fd, username) == -1
                 || send_string(context->foreground_fd, password) == -1
+                || send_string(context->foreground_fd, untrusted_ip) == -1
+                || send_string(context->foreground_fd, untrusted_ip6) == -1
                 || send_string(context->foreground_fd, common_name) == -1)
             {
                 fprintf(stderr, "AUTH-PAM: Error sending auth info to
background process\n");
@@ -681,6 +687,16 @@
     status = pam_start(service, name_value_list_provided ? NULL :
up->username, &conv, &pamh);
     if (status == PAM_SUCCESS)
     {
+
+        if (strlen(up->untrusted_ip) > 0)
+        {
+            pam_set_item(pamh, PAM_RHOST, up->untrusted_ip);
+        }
+        else
+        {
+            pam_set_item(pamh, PAM_RHOST, up->untrusted_ip6);
+        }
+
         /* Call PAM to verify username/password */
         status = pam_authenticate(pamh, 0);
         if (status == PAM_SUCCESS)
@@ -770,6 +786,8 @@
             case COMMAND_VERIFY:
                 if (recv_string(fd, up.username, sizeof(up.username)) == -1
                     || recv_string(fd, up.password, sizeof(up.password)) == -1
+                    || recv_string(fd, up.untrusted_ip,
sizeof(up.untrusted_ip)) == -1
+                    || recv_string(fd, up.untrusted_ip6,
sizeof(up.untrusted_ip6)) == -1
                     || recv_string(fd, up.common_name,
sizeof(up.common_name)) == -1)
                 {
                     fprintf(stderr, "AUTH-PAM: BACKGROUND: read error
on command channel: code=%d, exiting\n",


WBR,
Martin

