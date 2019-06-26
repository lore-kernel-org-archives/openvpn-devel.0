From: Paolo <wardragon78@...277...>
Message-ID: <da61f7b0-f9e1-e4e7-3aa0-a0dd603a3f32@...277...>
Date: Wed, 26 Jun 2019 15:37:56 +0200
MIME-Version: 1.0
Content-Language: it-IT
Subject: [Openvpn-devel] Patch for pam recent module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

hi,

i make a pull reuqest ofr this patch some times ago over github, this
patch implements the right peace of software for passing ip and hostname
to pam modules, to use for example in firewall or modules like
pam_recent, this patch is succefull running by more tha 7 years into our
systems.


diff --git a/src/plugins/auth-pam/auth-pam.c
b/src/plugins/auth-pam/auth-pam.c
index 88b53204..9d8dfb95 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -115,6 +115,7 @@ struct user_pass {
=A0=A0=A0=A0 char password[128];
=A0=A0=A0=A0 char common_name[128];
=A0=A0=A0=A0 char response[128];
+=A0=A0=A0 char remote[128];
=A0
=A0=A0=A0=A0 const struct name_value_list *name_value_list;
=A0};
@@ -517,13 +518,15 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t
handle, const int type, const cha
=A0=A0=A0=A0=A0=A0=A0=A0 const char *username =3D get_env("username", envp);
=A0=A0=A0=A0=A0=A0=A0=A0 const char *password =3D get_env("password", envp);
=A0=A0=A0=A0=A0=A0=A0=A0 const char *common_name =3D get_env("common_name",=
 envp) ?
get_env("common_name", envp) : "";
+=A0=A0=A0=A0=A0=A0=A0 const char *remote =3D get_env("untrusted_ip", envp)=
 ?
get_env("untrusted_ip", envp) : get_env("untrusted_ip6", envp);
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 if (username && strlen(username) > 0 && password)
=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (send_control(context->foreground_f=
d, COMMAND_VERIFY) =3D=3D -1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || send_string(context->fo=
reground_fd, username) =3D=3D -1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || send_string(context->fo=
reground_fd, password) =3D=3D -1
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || send_string(context->fore=
ground_fd, common_name) =3D=3D -1)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || send_string(context->fore=
ground_fd, common_name) =3D=3D -1
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || send_string(context->fore=
ground_fd, remote) =3D=3D -1)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "AUTH-PAM:=
 Error sending auth info to
background process\n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
@@ -750,8 +753,16 @@ pam_auth(const char *service, const struct
user_pass *up)
=A0=A0=A0=A0 status =3D pam_start(service, name_value_list_provided ? NULL :
up->username, &conv, &pamh);
=A0=A0=A0=A0 if (status =3D=3D PAM_SUCCESS)
=A0=A0=A0=A0 {
+=A0=A0=A0=A0=A0=A0=A0 /* Set PAM_RHOST environment variable */
+=A0=A0=A0=A0=A0=A0=A0 if (*(up->remote))
+=A0=A0=A0=A0=A0=A0=A0 {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D pam_set_item(pamh, PAM_RHOST,=
 up->remote);
+=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 /* Call PAM to verify username/password */
-=A0=A0=A0=A0=A0=A0=A0 status =3D pam_authenticate(pamh, 0);
+=A0=A0=A0=A0=A0=A0=A0 if (status =3D=3D PAM_SUCCESS)
+=A0=A0=A0=A0=A0=A0=A0 {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D pam_authenticate(pamh, 0);
+=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (status =3D=3D PAM_SUCCESS)
=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D pam_acct_mgmt(pamh, 0);
@@ -839,7 +850,8 @@ pam_server(int fd, const char *service, int verb,
const struct name_value_list *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case COMMAND_VERIFY:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (recv_string(fd, up.use=
rname, sizeof(up.username)) =3D=3D -1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || recv_string=
(fd, up.password,
sizeof(up.password)) =3D=3D -1
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || recv_string(f=
d, up.common_name,
sizeof(up.common_name)) =3D=3D -1)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || recv_string(f=
d, up.common_name,
sizeof(up.common_name)) =3D=3D -1
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || recv_string(f=
d, up.remote, sizeof(up.remote)) =3D=3D -1)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr=
, "AUTH-PAM: BACKGROUND: read error
on command channel: code=3D%d, exiting\n",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 command);
@@ -853,6 +865,7 @@ pam_server(int fd, const char *service, int verb,
const struct name_value_list *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 up.username, up.password);
=A0#else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr=
, "AUTH-PAM: BACKGROUND: USER: %s\n",
up.username);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, =
"AUTH-PAM: BACKGROUND: REMOTE:
%s\n", up.remote);
=A0#endif
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

--=20
-----***********-----
Paolo Cerrito
-----***********-----


