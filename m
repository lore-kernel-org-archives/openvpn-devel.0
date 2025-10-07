From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 10:39:30 +0000
In-Reply-To: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
References: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e7454f0e1584e28994ecc9bb85fef3875bdaf4bd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hwQ1JkgCJ0w="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hwQ1JkgCJ0w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail

to look at the new patch set (#2).


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
---
M COPYING
1 file changed, 7 insertions(+), 178 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1249/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--hwQ1JkgCJ0w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">COPYING: Remove licenses for software bundled in=
 the Windows client<br><br>This is wildly outdated:<br> - we do not use NSI=
S or devcon.exe,<br> - the OpenSSL license hasn&#39;t been updated<br><br>I=
n general this file is confusing, since clearly it only<br>applies to the W=
indows client. It does not document the<br>licenses used throughout the sou=
rce code.<br><br>So instead of updating it here, move the duty of documenti=
ng<br>the licenses to the Windows installer build (in<br>openvpn-build repo=
sitory).<br><br>v2:<br> - add back LZO linking exception, this is required =
for anyone<br>   who wants to distribute openvpn binaries not just us.<br><=
br>Change-Id: I1aeed74dedf6dd5f559f4eb5cc84645f149ba788<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M COPYING<br>1 file cha=
nged, 7 insertions(+), 178 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1249/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/COPYING b/COPYING</span><br><span>index 3eb9468..e276079 100644</s=
pan><br><span>--- a/COPYING</span><br><span>+++ b/COPYING</span><br><span>@=
@ -17,7 +17,7 @@</span><br><span> OpenVPN license:</span><br><span> -------=
---------</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  OpenVPN is distributed under the GPL license version 2 (see Below).=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN is distri=
buted under the GPL license version 2.</span><br><span> </span><br><span>  =
 Special exception for linking OpenVPN with OpenSSL:</span><br><span> </spa=
n><br><span>@@ -73,187 +73,16 @@</span><br><span>    in this license except=
ion, you CANNOT distribute an OpenVPN binary</span><br><span>    linked wit=
h this library.</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-LZO license:</span><br><span>-------------</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+LZO linking exception:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+----------------------</span><br><spa=
n> </span><br><span>   LZO is Copyright (C) Markus F.X.J. Oberhumer,</span>=
<br><span>   and is licensed under the GPL.</span><br><span> </span><br><sp=
an>   Special exception for linking OpenVPN with both OpenSSL and LZO:</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Hereby=
 I grant a special exception to the OpenVPN project </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  (http://openvpn.net/) to link the LZO lib=
rary with </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the OpenS=
SL library (http://www.openssl.org).</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  H=
ereby I grant a special exception to the OpenVPN project</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  (https://openvpn.net/) to link the L=
ZO library with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  th=
e OpenSSL library (https://www.openssl.org).</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>   Markus F.X.J. Oberhumer</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-TAP-Win32/TAP-Win64 Driver license:</span><br><sp=
an>------------------------------------</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  T=
his device driver was inspired by the CIPE-Win32 driver by</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  Damion K. Wilson.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  The source and object code of the TAP-Win32/TAP-Win64 drive=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  is Copyright (C) 2=
002-2018 OpenVPN Inc, and is released under</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  the GPL version 2.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
Windows DDK Samples:</span><br><span>---------------------</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  The Windows binary distribution includes devcon.exe, a</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  Microsoft DDK sample w=
hich is redistributed under the terms</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  of the DDK EULA.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-NSIS Lic=
ense:</span><br><span>--------------</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Copy=
right (C) 2002-2003 Joost Verburg</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This so=
ftware is provided &#39;as-is&#39;, without any express or implied</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  warranty. In no event will t=
he authors be held liable for any damages</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  arising from the use of this software.</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  Permission is granted to anyone to use this software fo=
r any purpose,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  inclu=
ding commercial applications, and to alter it and redistribute</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  it freely, subject to the follow=
ing restrictions:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  1. The origin of this s=
oftware must not be misrepresented; </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     you must not claim that you wrote the original software=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     If you use this=
 software in a product, an acknowledgment in the</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     product documentation would be appreciated =
but is not required.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 2. Altered versions must be plainly marked as such,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     and must not be misrepresented as bein=
g the original software.</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  3. This notice may not be removed or altered from any distribution.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-OpenSSL License:</span><br><span>----------=
-------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  The OpenSSL toolkit stays under a=
 dual license, i.e. both the conditions of</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  the OpenSSL License and the original SSLeay license =
apply to the toolkit.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  See below for the actual license texts. Actually both licenses are BSD-st=
yle</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Open Source lice=
nses. In case of any license issues related to OpenSSL</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  please contact openssl-core@...2943...</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Cop=
yright (c) 1998-2003 The OpenSSL Project.  All rights reserved.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * Redistribution and use in source and binary forms=
, with or without</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * m=
odification, are permitted provided that the following conditions</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * are met:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * 1. Redistributions of source code must retain the above c=
opyright</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    notice,=
 this list of conditions and the following disclaimer. </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * 2. Redistributions in binary form must reproduce the abov=
e copyright</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    noti=
ce, this list of conditions and the following disclaimer in</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *    the documentation and/or other =
materials provided with the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *    distribution.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * 3. All adver=
tising materials mentioning features or use of this</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *    software must display the following a=
cknowledgment:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    &=
quot;This product includes software developed by the OpenSSL Project</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *    for use in the OpenSSL=
 Toolkit. (http://www.openssl.org/)&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * 4. The names &quot;OpenSSL Toolkit&quot; and &quot;OpenSSL Project&quot=
; must not be used to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *    endorse or promote products derived from this software without</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *    prior written permissi=
on. For written permission, please contact</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *    openssl-core@...2943...</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * 5. Products derived from this software may not be called &quot=
;OpenSSL&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    n=
or may &quot;OpenSSL&quot; appear in their names without prior written</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *    permission of the Op=
enSSL Project.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * 6. Redistributions of a=
ny form whatsoever must retain the following</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *    acknowledgment:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *    &quot;This product includes software developed=
 by the OpenSSL Project</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *    for use in the OpenSSL Toolkit (http://www.openssl.org/)&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * THIS SOFTWARE IS PROVIDED BY THE OpenSSL=
 PROJECT ``AS IS&#39;&#39; AND ANY</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED=
 TO, THE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * IMPLIED WA=
RRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * PURPOSE ARE DISCLAIMED.  IN NO EVENT =
SHALL THE OpenSSL PROJECT OR</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * SPECIAL, EXEMPLARY,=
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR S=
ERVICES;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * LOSS OF US=
E, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, =
WHETHER IN CONTRACT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * ARISING IN ANY WAY OUT OF THE =
USE OF THIS SOFTWARE, EVEN IF ADVISED</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * OF THE POSSIBILITY OF SUCH DAMAGE.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * This product includes =
cryptographic software written by Eric Young</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * (eay@...2490...).  This product includes software=
 written by Tim</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Hud=
son (tjh@...2490...).</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- Original SSLeay License</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- -----------------------</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/* Copyright (C) 1995-1998 Eric Young (eay@...2490...)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * All rights reserved.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * This package is an SSL implementation written</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * by Eric Young (eay@...2945...=
..).</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The implementa=
tion was written so as to conform with Netscapes SSL.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * </span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * This library is free for commercial and non-commercial use=
 as long as</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the fol=
lowing conditions are aheared to.  The following conditions</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * apply to all code found in this di=
stribution, be it the RC4, RSA,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * lhash, DES, etc., code; not just the SSL code.  The SSL docume=
ntation</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * included wi=
th this distribution is covered by the same copyright terms</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * except that the holder is Tim Huds=
on (tjh@...2490...).</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* </span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Copyright remain=
s Eric Young&#39;s, and as such any Copyright notices in</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * the code are not to be removed.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * If this package is used =
in a product, Eric Young should be given attribution</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * as the author of the parts of the librar=
y used.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This can be=
 in the form of a textual message at program startup or</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * in documentation (online or textual) p=
rovided with the package.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * </span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Redistribut=
ion and use in source and binary forms, with or without</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * modification, are permitted provided t=
hat the following conditions</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * are met:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
1. Redistributions of source code must retain the copyright</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *    notice, this list of conditions=
 and the following disclaimer.</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * 2. Redistributions in binary form must reproduce the above copy=
right</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    notice, th=
is list of conditions and the following disclaimer in the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *    documentation and/or other materi=
als provided with the distribution.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * 3. All advertising materials mentioning features or use of=
 this software</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    m=
ust display the following acknowledgement:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *    &quot;This product includes cryptographic softwa=
re written by</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *     E=
ric Young (eay@...2490...)&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *    The word &#39;cryptographic&#39; can be left out if the ro=
uines from the library</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *    being used are not cryptographic related :-).</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * 4. If you include any Windows specific c=
ode (or a derivative thereof) from </span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *    the apps directory (application code) you must include =
an acknowledgement:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
    &quot;This product includes software written by Tim Hudson (tjh@...2946...=
...)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * THIS SOFTWARE IS PROVIDED =
BY ERIC YOUNG ``AS IS&#39;&#39; AND</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMI=
TED TO, THE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * IMPLIED=
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * ARE DISCLAIMED.  IN NO EVE=
NT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, E=
XEMPLARY, OR CONSEQUENTIAL</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE G=
OODS</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OR SERVICES; L=
OSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * HOWEVER CAUSED AND ON ANY THEORY OF LI=
ABILITY, WHETHER IN CONTRACT, STRICT</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) AR=
ISING IN ANY WAY</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OU=
T OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * SUCH DAMAGE.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * The licence and distribution terms for any public=
ally available version or</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * derivative of this code cannot be changed.  i.e. this code cannot si=
mply be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * copied and =
put under another distribution licence</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * [including the GNU Public Licence.]</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-GNU P=
ublic License (GPL)</span><br><span>-------------------------</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  OpenVPN, LZO, and the TAP-Win32 distributions are</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  licensed under the GPL v=
ersion 2 (see COPYRIGHT.GPL).</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  In the Wind=
ows binary distribution of OpenVPN, the</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  GPL is reproduced below.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail">change 1=
249</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1aeed74dedf6dd5f559f4eb5cc8=
4645f149ba788 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1249 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--hwQ1JkgCJ0w=--

