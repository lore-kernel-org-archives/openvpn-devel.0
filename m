From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 12:44:05 +0000
In-Reply-To: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
References: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <12700ba481feac966666bda07fc582a5d290e290-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ss19j8a1qJY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: COPYING: Remove
 licenses for software bundled in the Windows client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ss19j8a1qJY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: COPYING: Remove licenses for software bundled in the Window=
s client
......................................................................

COPYING: Remove licenses for software bundled in the Windows client

This is wildly outdated:
 - we do not use NSIS or devcon.exe,
 - the OpenSSL license hasn't been updated

In general this file is confusing, since clearly it only
applies to the Windows client. It does not document the
licenses used throughout the source code.

So instead of updating it here, move the duty of documenting
the licenses to the Windows installer build (in
openvpn-build repository).

v2:
 - add back LZO linking exception, this is required for anyone
   who wants to distribute openvpn binaries not just us.

Change-Id: I1aeed74dedf6dd5f559f4eb5cc84645f149ba788
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1249
Message-Id: <20251007104820.7781-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243256/
Signed-off-by: Gert Doering <gert@...1296...>
---
M COPYING
1 file changed, 7 insertions(+), 178 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1249/3

diff --git a/COPYING b/COPYING
index 3eb9468..e276079 100644
--- a/COPYING
+++ b/COPYING
@@ -17,7 +17,7 @@
 OpenVPN license:
 ----------------

-  OpenVPN is distributed under the GPL license version 2 (see Below).
+  OpenVPN is distributed under the GPL license version 2.

   Special exception for linking OpenVPN with OpenSSL:

@@ -73,187 +73,16 @@
    in this license exception, you CANNOT distribute an OpenVPN binary
    linked with this library.

-LZO license:
-------------
+LZO linking exception:
+----------------------

   LZO is Copyright (C) Markus F.X.J. Oberhumer,
   and is licensed under the GPL.

   Special exception for linking OpenVPN with both OpenSSL and LZO:
=20
-  Hereby I grant a special exception to the OpenVPN project
-  (http://openvpn.net/) to link the LZO library with
-  the OpenSSL library (http://www.openssl.org).
-
+  Hereby I grant a special exception to the OpenVPN project
+  (https://openvpn.net/) to link the LZO library with
+  the OpenSSL library (https://www.openssl.org).
+
   Markus F.X.J. Oberhumer
-
-TAP-Win32/TAP-Win64 Driver license:
------------------------------------
-
-  This device driver was inspired by the CIPE-Win32 driver by
-  Damion K. Wilson.
-
-  The source and object code of the TAP-Win32/TAP-Win64 driver
-  is Copyright (C) 2002-2018 OpenVPN Inc, and is released under
-  the GPL version 2.
-
-Windows DDK Samples:
---------------------
-
-  The Windows binary distribution includes devcon.exe, a
-  Microsoft DDK sample which is redistributed under the terms
-  of the DDK EULA.
-
-NSIS License:
--------------
-
-  Copyright (C) 2002-2003 Joost Verburg
-
-  This software is provided 'as-is', without any express or implied
-  warranty. In no event will the authors be held liable for any damages
-  arising from the use of this software.
-
-  Permission is granted to anyone to use this software for any purpose,
-  including commercial applications, and to alter it and redistribute
-  it freely, subject to the following restrictions:
-
-  1. The origin of this software must not be misrepresented;
-     you must not claim that you wrote the original software.
-     If you use this software in a product, an acknowledgment in the
-     product documentation would be appreciated but is not required.
-  2. Altered versions must be plainly marked as such,
-     and must not be misrepresented as being the original software.
-  3. This notice may not be removed or altered from any distribution.
-
-OpenSSL License:
-----------------
-
-  The OpenSSL toolkit stays under a dual license, i.e. both the conditions=
 of
-  the OpenSSL License and the original SSLeay license apply to the toolkit.
-  See below for the actual license texts. Actually both licenses are BSD-s=
tyle
-  Open Source licenses. In case of any license issues related to OpenSSL
-  please contact openssl-core@...2943...
-
-/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- * Copyright (c) 1998-2003 The OpenSSL Project.  All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * 3. All advertising materials mentioning features or use of this
- *    software must display the following acknowledgment:
- *    "This product includes software developed by the OpenSSL Project
- *    for use in the OpenSSL Toolkit. (http://www.openssl.org/)"
- *
- * 4. The names "OpenSSL Toolkit" and "OpenSSL Project" must not be used to
- *    endorse or promote products derived from this software without
- *    prior written permission. For written permission, please contact
- *    openssl-core@...2943...
- *
- * 5. Products derived from this software may not be called "OpenSSL"
- *    nor may "OpenSSL" appear in their names without prior written
- *    permission of the OpenSSL Project.
- *
- * 6. Redistributions of any form whatsoever must retain the following
- *    acknowledgment:
- *    "This product includes software developed by the OpenSSL Project
- *    for use in the OpenSSL Toolkit (http://www.openssl.org/)"
- *
- * THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY
- * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE OpenSSL PROJECT OR
- * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
- * OF THE POSSIBILITY OF SUCH DAMAGE.
- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- *
- * This product includes cryptographic software written by Eric Young
- * (eay@...2490...).  This product includes software written by Tim
- * Hudson (tjh@...2490...).
- *
- */
-
- Original SSLeay License
- -----------------------
-
-/* Copyright (C) 1995-1998 Eric Young (eay@...2490...)
- * All rights reserved.
- *
- * This package is an SSL implementation written
- * by Eric Young (eay@...2490...).
- * The implementation was written so as to conform with Netscapes SSL.
- *
- * This library is free for commercial and non-commercial use as long as
- * the following conditions are aheared to.  The following conditions
- * apply to all code found in this distribution, be it the RC4, RSA,
- * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
- * included with this distribution is covered by the same copyright terms
- * except that the holder is Tim Hudson (tjh@...2490...).
- *
- * Copyright remains Eric Young's, and as such any Copyright notices in
- * the code are not to be removed.
- * If this package is used in a product, Eric Young should be given attrib=
ution
- * as the author of the parts of the library used.
- * This can be in the form of a textual message at program startup or
- * in documentation (online or textual) provided with the package.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. All advertising materials mentioning features or use of this software
- *    must display the following acknowledgement:
- *    "This product includes cryptographic software written by
- *     Eric Young (eay@...2490...)"
- *    The word 'cryptographic' can be left out if the rouines from the lib=
rary
- *    being used are not cryptographic related :-).
- * 4. If you include any Windows specific code (or a derivative thereof) f=
rom
- *    the apps directory (application code) you must include an acknowledg=
ement:
- *    "This product includes software written by Tim Hudson (tjh@...2944...=
.)"
- *
- * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENT=
IAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STR=
ICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY W=
AY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * The licence and distribution terms for any publically available version=
 or
- * derivative of this code cannot be changed.  i.e. this code cannot simpl=
y be
- * copied and put under another distribution licence
- * [including the GNU Public Licence.]
- */
-
-GNU Public License (GPL)
-------------------------
-
-  OpenVPN, LZO, and the TAP-Win32 distributions are
-  licensed under the GPL version 2 (see COPYRIGHT.GPL).
-
-  In the Windows binary distribution of OpenVPN, the
-  GPL is reproduced below.
-

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1aeed74dedf6dd5f559f4eb5cc84645f149ba788
Gerrit-Change-Number: 1249
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ss19j8a1qJY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">COPYING: Remove licenses for so=
ftware bundled in the Windows client<br><br>This is wildly outdated:<br> - =
we do not use NSIS or devcon.exe,<br> - the OpenSSL license hasn&#39;t been=
 updated<br><br>In general this file is confusing, since clearly it only<br=
>applies to the Windows client. It does not document the<br>licenses used t=
hroughout the source code.<br><br>So instead of updating it here, move the =
duty of documenting<br>the licenses to the Windows installer build (in<br>o=
penvpn-build repository).<br><br>v2:<br> - add back LZO linking exception, =
this is required for anyone<br>   who wants to distribute openvpn binaries =
not just us.<br><br>Change-Id: I1aeed74dedf6dd5f559f4eb5cc84645f149ba788<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arn=
e Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/1249<br>Message-Id: &lt;20251007104820.7781-1-gert@...493...=
1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59243=
256/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M COP=
YING<br>1 file changed, 7 insertions(+), 178 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1=
249/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/COPYING b/COPYING</span><br><span>index 3eb9468.=
.e276079 100644</span><br><span>--- a/COPYING</span><br><span>+++ b/COPYING=
</span><br><span>@@ -17,7 +17,7 @@</span><br><span> OpenVPN license:</span>=
<br><span> ----------------</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  OpenVPN is distributed under the GPL license vers=
ion 2 (see Below).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 OpenVPN is distributed under the GPL license version 2.</span><br><span> <=
/span><br><span>   Special exception for linking OpenVPN with OpenSSL:</spa=
n><br><span> </span><br><span>@@ -73,187 +73,16 @@</span><br><span>    in t=
his license exception, you CANNOT distribute an OpenVPN binary</span><br><s=
pan>    linked with this library.</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-LZO license:</span><br><span>-------------<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+LZO linking exceptio=
n:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----------------=
-----</span><br><span> </span><br><span>   LZO is Copyright (C) Markus F.X.=
J. Oberhumer,</span><br><span>   and is licensed under the GPL.</span><br><=
span> </span><br><span>   Special exception for linking OpenVPN with both O=
penSSL and LZO:</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  Hereby I grant a special exception to the OpenVPN project </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  (http://openvpn.net/) =
to link the LZO library with </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  the OpenSSL library (http://www.openssl.org).</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  Hereby I grant a special exception to the OpenVPN project=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (https://openvpn.=
net/) to link the LZO library with</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  the OpenSSL library (https://www.openssl.org).</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   Markus F.X.=
J. Oberhumer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-TAP-Win32/TAP-Win64 Driver lic=
ense:</span><br><span>------------------------------------</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  This device driver was inspired by the CIPE-Win32 driver =
by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Damion K. Wilson.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  The source and object code of the TAP-Wi=
n32/TAP-Win64 driver</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 is Copyright (C) 2002-2018 OpenVPN Inc, and is released under</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  the GPL version 2.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-Windows DDK Samples:</span><br><span>-------------------=
--</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  The Windows binary distribution includ=
es devcon.exe, a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Mic=
rosoft DDK sample which is redistributed under the terms</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  of the DDK EULA.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-NSIS License:</span><br><span>--------------</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  Copyright (C) 2002-2003 Joost Verburg</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  This software is provided &#39;as-is&#39;, without any express=
 or implied</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  warranty=
. In no event will the authors be held liable for any damages</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  arising from the use of this soft=
ware.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  Permission is granted to anyone to =
use this software for any purpose,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  including commercial applications, and to alter it and redis=
tribute</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  it freely, s=
ubject to the following restrictions:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  1. =
The origin of this software must not be misrepresented; </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     you must not claim that you wrote t=
he original software.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     If you use this software in a product, an acknowledgment in the</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     product documentation w=
ould be appreciated but is not required.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  2. Altered versions must be plainly marked as such,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     and must not be mis=
represented as being the original software.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  3. This notice may not be removed or altered from a=
ny distribution.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenSSL License:</span><br=
><span>-----------------</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The OpenSSL tool=
kit stays under a dual license, i.e. both the conditions of</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  the OpenSSL License and the origina=
l SSLeay license apply to the toolkit.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  See below for the actual license texts. Actually both li=
censes are BSD-style</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 Open Source licenses. In case of any license issues related to OpenSSL</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  please contact openssl-=
core@...2943...</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/* =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Copyright (c) 1998-2003 The OpenSSL Project.  All rights reserv=
ed.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Redistribution and use in source a=
nd binary forms, with or without</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * modification, are permitted provided that the following condi=
tions</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * are met:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * 1. Redistributions of source code must r=
etain the above copyright</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *    notice, this list of conditions and the following disclaimer. </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * 2. Redistributions in binary form must r=
eproduce the above copyright</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *    notice, this list of conditions and the following disclaimer i=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    the documentat=
ion and/or other materials provided with the</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *    distribution.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * 3. All advertising materials mentioning features or use of this</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *    software must display =
the following acknowledgment:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *    &quot;This product includes software developed by the OpenSSL=
 Project</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    for use=
 in the OpenSSL Toolkit. (http://www.openssl.org/)&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * 4. The names &quot;OpenSSL Toolkit&quot; and &quot;OpenS=
SL Project&quot; must not be used to</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *    endorse or promote products derived from this software=
 without</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    prior w=
ritten permission. For written permission, please contact</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *    openssl-core@...2943...</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * 5. Products derived from this software may not =
be called &quot;OpenSSL&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *    nor may &quot;OpenSSL&quot; appear in their names without pri=
or written</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    permi=
ssion of the OpenSSL Project.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * 6. Redis=
tributions of any form whatsoever must retain the following</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *    acknowledgment:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *    &quot;This product includes sof=
tware developed by the OpenSSL Project</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *    for use in the OpenSSL Toolkit (http://www.openssl.o=
rg/)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * THIS SOFTWARE IS PROVIDED B=
Y THE OpenSSL PROJECT ``AS IS&#39;&#39; AND ANY</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BU=
T NOT LIMITED TO, THE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * PURPOSE ARE DISCLAIMED. =
 IN NO EVENT SHALL THE OpenSSL PROJECT OR</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,=
 INCIDENTAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * SPECIA=
L, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * NOT LIMITED TO, PROCUREMENT OF SUBSTITU=
TE GOODS OR SERVICES;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * HOWEVER CAUSED AND ON ANY THEORY O=
F LIABILITY, WHETHER IN CONTRACT,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ARISING IN ANY WA=
Y OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * OF THE POSSIBILITY OF SUCH DAMAGE.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This produ=
ct includes cryptographic software written by Eric Young</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * (eay@...2490...).  This product inclu=
des software written by Tim</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Hudson (tjh@...2490...).</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- Original SSLeay License</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- -----------------------</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/* Copyright (C) 1995-1998 Eric Young (eay@...2490...)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * All rights reserved.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * This package is an SSL implementation wr=
itten</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * by Eric Young=
 (eay@...2490...).</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
The implementation was written so as to conform with Netscapes SSL.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * This library is free for commercial and non-=
commercial use as long as</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * the following conditions are aheared to.  The following conditions</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * apply to all code fo=
und in this distribution, be it the RC4, RSA,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * lhash, DES, etc., code; not just the SSL code.  =
The SSL documentation</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * included with this distribution is covered by the same copyright terms</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * except that the hold=
er is Tim Hudson (tjh@...2490...).</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * </span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Co=
pyright remains Eric Young&#39;s, and as such any Copyright notices in</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * the code are not to be =
removed.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If this pa=
ckage is used in a product, Eric Young should be given attribution</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * as the author of the parts =
of the library used.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* This can be in the form of a textual message at program startup or</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * in documentation (online =
or textual) provided with the package.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Redistribution and use in source and binary forms, with or without</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * modification, are permitt=
ed provided that the following conditions</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * are met:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * 1. Redistributions of source code must retain the copyright</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *    notice, this list =
of conditions and the following disclaimer.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * 2. Redistributions in binary form must reproduce t=
he above copyright</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
   notice, this list of conditions and the following disclaimer in the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *    documentation and/or=
 other materials provided with the distribution.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * 3. All advertising materials mentioning featu=
res or use of this software</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *    must display the following acknowledgement:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *    &quot;This product includes cryptog=
raphic software written by</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *     Eric Young (eay@...2490...)&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *    The word &#39;cryptographic&#39; can be left =
out if the rouines from the library</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *    being used are not cryptographic related :-).</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * 4. If you include any Window=
s specific code (or a derivative thereof) from </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *    the apps directory (application code) you m=
ust include an acknowledgement:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *    &quot;This product includes software written by Tim Hudson =
(tjh@...2490...)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * </span><br><span style=3D"color: hsl(0, 100%, 40%);">- * THIS SOFTWARE =
IS PROVIDED BY ERIC YOUNG ``AS IS&#39;&#39; AND</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, =
BUT NOT LIMITED TO, THE</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PUR=
POSE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ARE DISCLAIMED=
.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * FOR ANY DIRECT, INDIRECT, INCIDENTAL=
, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF =
SUBSTITUTE GOODS</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OR=
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * HOWEVER CAUSED AND ON ANY =
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR O=
THERWISE) ARISING IN ANY WAY</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILI=
TY OF</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * SUCH DAMAGE.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * The licence and distribution terms fo=
r any publically available version or</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * derivative of this code cannot be changed.  i.e. this co=
de cannot simply be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 copied and put under another distribution licence</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * [including the GNU Public Licence.]</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-GNU Public License (GPL)</span><br><span>-------------------------</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  OpenVPN, LZO, and the TAP-Win32 distribut=
ions are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  licensed un=
der the GPL version 2 (see COPYRIGHT.GPL).</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  In the Windows binary distribution of OpenVPN, the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  GPL is reproduced below.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3De=
mail">change 1249</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1aeed74dedf6dd5f559f4eb5cc8=
4645f149ba788 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1249 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Ss19j8a1qJY=--

