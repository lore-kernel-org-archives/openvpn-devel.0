references: <1424010266-5910-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
message-id: <54E0B4A2.5090006@...1227...>
Date: Sun, 15 Feb 2015 16:00:50 +0100
mime-version: 1.0
in-reply-to: <1424010266-5910-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Disable SSL compression
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

On 15.02.2015 15:24, Steffan Karger wrote:
> As reported in trac #502, SSL compression can cause problems in some corner
> cases.  OpenVPN does not need SSL compression, since the control channel is
> low bandwidth.  This does not influence the data channel compressen (i.e.
> --comp or --comp-lzo).
>
> Even though this has not yet been relevant for OpenVPN (since an attacker
> can not easily control contents of control channel messages), SSL
> compression has been used in the CRIME and BREACH attacks on TLS.  TLS 1.3
> will probably even remove support for compression all together, for
> exactly this reason.
>
> Since we don't need it, and SSL compression causes issues, let's just
> disable it in OpenSSL builds.  PolarSSL has no run-time flag to disable
> compression, but is by default compiled without compression.
>
ACK from me. Sounds sensible to me. If do not support 0.9.8 anymore (in
-master perhaps?) I would like this to be commited without ifdef.

Arne

