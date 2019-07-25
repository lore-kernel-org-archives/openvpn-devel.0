MIME-Version: 1.0
References: <aa4f4026-a684-f96d-c8cb-d4f8a3468c4c@...277...>
In-Reply-To: <aa4f4026-a684-f96d-c8cb-d4f8a3468c4c@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 25 Jul 2019 10:44:48 +0300
Message-ID: <CAGyAFMVBdD6tkNSnkZXqMUd5i-zA_d-q1W-OEpPvHtA8gPkSVA@...278...>
Content-Type: multipart/alternative; boundary="00000000000038b5eb058e7c9a85"
Subject: Re: [Openvpn-devel] Wrong FILETYPE in .rc files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gisle Vanem <gisle.vanem@...277...>
Cc: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

--00000000000038b5eb058e7c9a85
Content-Type: text/plain; charset="UTF-8"

Hi Gisle,

1. Please fix your patch, I cannot apply it:

c:\Users\lev\Projects\openvpn>git am
Openvpn-devel-Wrong-FILETYPE-in-.rc-files.patch
error: patch failed: src/openvpn/openvpn_win32_resources.rc:19
error: src/openvpn/openvpn_win32_resources.rc: patch does not apply
error: patch failed: src/openvpnserv/openvpnserv_resources.rc:19
error: src/openvpnserv/openvpnserv_resources.rc: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: Wrong FILETYPE in .rc files
Patch failed at 0001 Wrong FILETYPE in .rc files
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Use git-send-email for sending patches.

2. Add "Signed-off-by" line to commit message (use git commit -s).

3. Since you patch .rc files, could you replace rest of numeric values with
strings, like

FILEOS VOS_NT_WINDOWS32 instead of FILEOS 0x40004L

-- 
-Lev

--00000000000038b5eb058e7c9a85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Gisle,<div><br></div><div>1. Please fi=
x your patch, I cannot apply it:</div><div><br></div><div>c:\Users\lev\Proj=
ects\openvpn&gt;git am Openvpn-devel-Wrong-FILETYPE-in-.rc-files.patch<br>e=
rror: patch failed: src/openvpn/openvpn_win32_resources.rc:19<br>error: src=
/openvpn/openvpn_win32_resources.rc: patch does not apply<br>error: patch f=
ailed: src/openvpnserv/openvpnserv_resources.rc:19<br>error: src/openvpnser=
v/openvpnserv_resources.rc: patch does not apply<br>hint: Use &#39;git am -=
-show-current-patch&#39; to see the failed patch<br>Applying: Wrong FILETYP=
E in .rc files<br>Patch failed at 0001 Wrong FILETYPE in .rc files<br>When =
you have resolved this problem, run &quot;git am --continue&quot;.<br>If yo=
u prefer to skip this patch, run &quot;git am --skip&quot; instead.<br>To r=
estore the original branch and stop patching, run &quot;git am --abort&quot=
;.<br></div><div><br></div><div>Use git-send-email for sending patches.</di=
v><div><br></div><div>2. Add &quot;Signed-off-by&quot; line to commit messa=
ge (use git commit -s).</div><div><br></div><div>3. Since you patch .rc fil=
es, could you replace rest of numeric values with strings, like=C2=A0</div>=
<div><br></div><div>FILEOS VOS_NT_WINDOWS32 instead of FILEOS 0x40004L</div=
><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Le=
v</div></div>

--00000000000038b5eb058e7c9a85--

