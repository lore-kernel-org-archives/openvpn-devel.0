Date: Sat, 29 Nov 2025 14:43:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aSr4hZgQWtFl-qLL@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TySmTurNqCN3qoUT"
Content-Disposition: inline
Subject: [Openvpn-devel] CVE fix for Windows in 2.5, 2.6, 2.7_rc3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--TySmTurNqCN3qoUT
Content-Type: multipart/mixed; boundary="5fzNw8Z8aST6uZc0"
Content-Disposition: inline

--5fzNw8Z8aST6uZc0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

you might have seen 2.6.17 and 2.7_rc3 releases yesterday, mentioning

    - Windows/Interactive Service: CVE-2025-13751
	fix bug where the interactive service would error-exit in
	certain error conditions instead of just logging the fact and
	continuing.  After the error-exit, OpenVPN connections will no
	longer work until the service is restarted (or the system rebooted).
	This can be triggered by any authenticated local user, and has
	thus been classified as a "local denial of service" attack.

as usual for bugs that we classify as "we do not want them to leak before
a fixed installer is out" the fix was developed & tested & reviewed in
private (Lev, Selva, Heiko).

Also, for the usual maximum transparency, I'll hereby send it to the list
- attached is the 2.7 patch, which is

commit 6088451b616be313bd47cfed8d82d47bd6e17d93
Author: Lev Stipakov <lev@...515...>
Date:   Mon Nov 24 12:09:23 2025 +0200

    interactive.c: harden pipe handling against misbehaving clients


the 2.6 patch is basically the same change, but the differences are=20
wide character text handling (TEXT("") vs. L"") between 2.6 and 2.7

commit 29d8eccface918703b91dde230285ca869f95090 (release/2.6)
Author: Lev Stipakov <lev@...515...>
Date:   Mon Nov 24 12:09:23 2025 +0200

    interactive.c: harden pipe handling against misbehaving clients


and, finally, the 2.5 patch is a direct cherrypick from 2.6

commit 1f4b444e1407450a1071a633d73d2a63a0af06c2 (release/2.5)
Author: Lev Stipakov <lev@...515...>
Date:   Mon Nov 24 12:09:23 2025 +0200

    interactive.c: harden pipe handling against misbehaving clients


Note that we do not intend to publish new 2.5.x windows installers - but
if someone is building their product on the 2.5 source tree, the fix
is in.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5fzNw8Z8aST6uZc0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-interactive.c-harden-pipe-handling-against-misbehavi.patch
Content-Transfer-Encoding: quoted-printable

=46rom 6088451b616be313bd47cfed8d82d47bd6e17d93 Mon Sep 17 00:00:00 2001
=46rom: Lev Stipakov <lev@...515...>
Date: Mon, 24 Nov 2025 12:09:23 +0200
Subject: [PATCH 1/2] interactive.c: harden pipe handling against misbehaving
 clients

 - Handle ConnectNamedPipe ERROR_NO_DATA as a normal
   connect/drop race: log the drop, disconnect/reset
   that instance, and keep listening instead of letting
   a trivial local DoS stop the service.

 - Add a timed peek for startup data so a client that
   connects and sends nothing is timed out (IO_TIMEOUT)
   and rejected, instead of leaving a worker thread blocked
   forever and piling up handles.

 - Protect the accept loop from resource exhaustion: before
   spawning a worker, check the wait set and reject the client
   if adding another handle would exceed MAXIMUM_WAIT_OBJECTS;
   also skip FlushFileBuffers when no startup data was received
   to avoid hangs on silent clients.

Without these fixes, a malicious local windows user can make the OpenVPN
Interactive Service exit-on-error, thus breaking all OpenVPN connections
until the service is restarted (or the system rebooted).  Thus this has
been classified as "local denial of service" and CVE-2025-13751 has been
assigned.

CVE: 2025-13751
Change-Id: Id6a13b0c8124117bcea2926b16607ef39344015a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 60 +++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 220c0427..6f04f6b5 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -208,6 +208,7 @@ ResetOverlapped(LPOVERLAPPED overlapped)
 typedef enum
 {
     peek,
+    peek_timed,
     read,
     write
 } async_op_t;
@@ -260,7 +261,7 @@ AsyncPipeOp(async_op_t op, HANDLE pipe, LPVOID buffer, =
DWORD size, DWORD count,
         goto out;
     }
=20
-    if (op =3D=3D peek)
+    if (op =3D=3D peek || op =3D=3D peek_timed)
     {
         PeekNamedPipe(pipe, NULL, 0, NULL, &bytes, NULL);
     }
@@ -281,6 +282,12 @@ PeekNamedPipeAsync(HANDLE pipe, DWORD count, LPHANDLE =
events)
     return AsyncPipeOp(peek, pipe, NULL, 0, count, events);
 }
=20
+static DWORD
+PeekNamedPipeAsyncTimed(HANDLE pipe, DWORD count, LPHANDLE events)
+{
+    return AsyncPipeOp(peek_timed, pipe, NULL, 0, count, events);
+}
+
 static DWORD
 ReadPipeAsync(HANDLE pipe, LPVOID buffer, DWORD size, DWORD count, LPHANDL=
E events)
 {
@@ -437,11 +444,11 @@ GetStartupData(HANDLE pipe, STARTUP_DATA *sud)
     WCHAR *data =3D NULL;
     DWORD bytes, read;
=20
-    bytes =3D PeekNamedPipeAsync(pipe, 1, &exit_event);
+    bytes =3D PeekNamedPipeAsyncTimed(pipe, 1, &exit_event);
     if (bytes =3D=3D 0)
     {
-        MsgToEventLog(M_SYSERR, L"PeekNamedPipeAsync failed");
-        ReturnLastError(pipe, L"PeekNamedPipeAsync");
+        MsgToEventLog(M_ERR, L"Timeout waiting for startup data");
+        ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData (timeout)",=
 1, &exit_event);
         goto err;
     }
=20
@@ -3248,6 +3255,7 @@ RunOpenvpn(LPVOID p)
     size_t cmdline_size;
     undo_lists_t undo_lists;
     WCHAR errmsg[512] =3D L"";
+    BOOL flush_pipe =3D TRUE;
=20
     SECURITY_ATTRIBUTES inheritable =3D { .nLength =3D sizeof(inheritable),
                                         .lpSecurityDescriptor =3D NULL,
@@ -3267,6 +3275,7 @@ RunOpenvpn(LPVOID p)
=20
     if (!GetStartupData(pipe, &sud))
     {
+        flush_pipe =3D FALSE; /* client did not provide startup data */
         goto out;
     }
=20
@@ -3562,7 +3571,10 @@ RunOpenvpn(LPVOID p)
     Undo(&undo_lists);
=20
 out:
-    FlushFileBuffers(pipe);
+    if (flush_pipe)
+    {
+        FlushFileBuffers(pipe);
+    }
     DisconnectNamedPipe(pipe);
=20
     free(ovpn_user);
@@ -3834,11 +3846,30 @@ ServiceStartInteractive(DWORD dwArgc, LPWSTR *lpszA=
rgv)
=20
     while (TRUE)
     {
-        if (ConnectNamedPipe(pipe, &overlapped) =3D=3D FALSE && GetLastErr=
or() !=3D ERROR_PIPE_CONNECTED
-            && GetLastError() !=3D ERROR_IO_PENDING)
+        if (!ConnectNamedPipe(pipe, &overlapped))
         {
-            MsgToEventLog(M_SYSERR, L"Could not connect pipe");
-            break;
+            DWORD connect_error =3D GetLastError();
+            if (connect_error =3D=3D ERROR_NO_DATA)
+            {
+                /*
+                 * Client connected and disconnected before we could proce=
ss it.
+                 * Disconnect and retry instead of aborting the service.
+                 */
+                MsgToEventLog(M_ERR, L"ConnectNamedPipe returned ERROR_NO_=
DATA (client dropped)");
+                DisconnectNamedPipe(pipe);
+                ResetOverlapped(&overlapped);
+                continue;
+            }
+            else if (connect_error =3D=3D ERROR_PIPE_CONNECTED)
+            {
+                /* No async I/O pending in this case; signal manually. */
+                SetEvent(overlapped.hEvent);
+            }
+            else if (connect_error !=3D ERROR_IO_PENDING)
+            {
+                MsgToEventLog(M_SYSERR, L"Could not connect pipe");
+                break;
+            }
         }
=20
         error =3D WaitForMultipleObjects(handle_count, handles, FALSE, INF=
INITE);
@@ -3846,6 +3877,17 @@ ServiceStartInteractive(DWORD dwArgc, LPWSTR *lpszAr=
gv)
         {
             /* Client connected, spawn a worker thread for it */
             HANDLE next_pipe =3D CreateClientPipeInstance();
+
+            /* Avoid exceeding WaitForMultipleObjects MAXIMUM_WAIT_OBJECTS=
 */
+            if (handle_count + 1 > MAXIMUM_WAIT_OBJECTS)
+            {
+                ReturnError(pipe, ERROR_CANT_WAIT, L"Too many concurrent c=
lients", 1, &exit_event);
+                CloseHandleEx(&pipe);
+                pipe =3D next_pipe;
+                ResetOverlapped(&overlapped);
+                continue;
+            }
+
             HANDLE thread =3D CreateThread(NULL, 0, RunOpenvpn, pipe, CREA=
TE_SUSPENDED, NULL);
             if (thread)
             {
--=20
2.51.2


--5fzNw8Z8aST6uZc0--

--TySmTurNqCN3qoUT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmkq+IMACgkQHYKe/spW
KBJN+Qv+KPpDmM5mQOQ9FOfcYXe5GvuQnW5JaM8gr8tcsltFaQuzZKasLu5WVPrN
yG+gTpID3VDZlCKHsMyBIc2MSf+3bxCw3yD+r7LMSHe6NdLVWhfre/j9kpR13nYY
wl0Foo2DunUbrad466FaJbGfuS65aEeVBaJpJ3XUFaQ70HpZ2dYQ1lGR0vK7e0Vn
k95pKaewtdzUrHg1p/EEuH55tCNGPuBPH09EqmCw0IO64liNG37V73cjmjWuLc8u
39Zzsc1TStuDnz49j3yeAKekIG421Q946OaV6HtIddCo3mAVL1RMZHECEh6sw2Wj
NnWGmkbsLaZmq+0AEcKFFCEDXEAChfX30cu3gyXTdq0opZ5bup6G4fUm8CiVDXjB
oETVwDF33NaaxryjNvdwRGNq22bFyYyt4UhjJOnYTxAHxygMCG12h8FNnMrI29c3
oC84/sgSVz24+lm5A+JroRCusZUH09PzQVqqGBnYPKyu6jYpFdjEJsRHF2VQQwNv
GnLQe1kH
=S6le
-----END PGP SIGNATURE-----

--TySmTurNqCN3qoUT--

