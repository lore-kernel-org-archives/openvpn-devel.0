From: Gert Doering <gert@...1296...>
Date: Tue,  7 Oct 2025 12:48:10 +0200
Message-ID: <20251007104820.7781-1-gert@...1296...>
In-Reply-To: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
References: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] COPYING: Remove licenses for software
 bundled in the Windows client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1249
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
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
-  The OpenSSL toolkit stays under a dual license, i.e. both the conditions of
-  the OpenSSL License and the original SSLeay license apply to the toolkit.
-  See below for the actual license texts. Actually both licenses are BSD-style
-  Open Source licenses. In case of any license issues related to OpenSSL
-  please contact openssl-core@...2943...
-
-/* ====================================================================
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
- * ====================================================================
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
- * If this package is used in a product, Eric Young should be given attribution
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
- *    The word 'cryptographic' can be left out if the rouines from the library
- *    being used are not cryptographic related :-).
- * 4. If you include any Windows specific code (or a derivative thereof) from 
- *    the apps directory (application code) you must include an acknowledgement:
- *    "This product includes software written by Tim Hudson (tjh@...2490...)"
- * 
- * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- * 
- * The licence and distribution terms for any publically available version or
- * derivative of this code cannot be changed.  i.e. this code cannot simply be
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

