Message-ID: <5138C0B3.2090808@...1227...>
Date: Thu, 07 Mar 2013 17:30:43 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
	<1362670601-18660-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1362670601-18660-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 3/3 v2] add new option for X.509 name
 verification
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Am 07.03.13 16:36, schrieb Heiko Hund:
> Add the option --verify-x509-name to provide the functionality
> of the now deprecated --tls-remote.
>
> The new option accepts RFC 2253 subject DNs only and compares
> RDN or RDN prefix only if configured explicitly.
ACK to man page changes. ACK to the rest of the patch if unchanged.

Arne

