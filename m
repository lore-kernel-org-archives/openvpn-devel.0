Message-ID: <515E8698.20701@...1227...>
Date: Fri, 05 Apr 2013 10:08:56 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B9013BC28A538@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013BC28A538@...1436...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed tls-cipher translation bug in
	openssl-build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 05.04.13 10:00, schrieb Steffan Karger:
> Hi,
>
> Attached a patch to fix a bug in the TLS-cipher translation introduced (by me) in commit 030c7b0. The previous version would not parse tls-cipher strings with more than two ciphers specified correctly.
>
> The patch has been tested by the user that reported the bug.
>

ACK from me. Also the user reporting the problem has tested the patch
and reports the patched version working.

Arne


