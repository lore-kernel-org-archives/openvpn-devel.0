From: Davide Brini <dave_br@...1278...>
Date: Mon, 19 Apr 2010 22:37:51 +0100
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
	<201003112141.01092.dave_br@...1278...>
	<4BCCC1ED.2030500@...1114...>
In-Reply-To: <4BCCC1ED.2030500@...1114...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v0MzLpTEcheXMc3"
Message-Id: <201004192237.51287.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--Boundary-00=_v0MzLpTEcheXMc3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Monday 19 April 2010, David Sommerseth wrote:

> I've done a quick test on one of my connections on Fedora 12 without any
> resolvconf package (meaning it invokes the simple cp approach), and it
> worked like a charm.
> 
> Applied to bugfix2.1 and merged into allmerged.
> Commit a9c9a89e96dc1e4e843e05ecadc4349b81606b06

Sorry, I just realized that I didn't change the sha-bang line in client.down. 
Apologies. Fix attached.

-- 
D.

--Boundary-00=_v0MzLpTEcheXMc3
Content-Type: text/x-patch; charset="UTF-8"; name="binsh-clientdown.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="binsh-clientdown.patch"

--- openvpn-2.1.1/contrib/pull-resolv-conf/client.down  2010-03-11 21:32:09.000000000 +0000
+++ openvpn-2.1.1-a/contrib/pull-resolv-conf/client.down        2010-04-19 22:33:53.000000000 +0100
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh

 # Copyright (c) 2005-2009 OpenVPN Technologies, Inc.
 # Licensed under the GPL version 2

--Boundary-00=_v0MzLpTEcheXMc3--

