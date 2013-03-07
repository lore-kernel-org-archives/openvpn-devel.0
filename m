Message-ID: <51389029.70608@...1227...>
Date: Thu, 07 Mar 2013 14:03:37 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
	<1361526263-1740-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1361526263-1740-3-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] make --tls-remote compatible with
 pre 2.3 configs
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

Am 22.02.13 10:44, schrieb Heiko Hund:
> In openvpn 2.3.0 the semantics of the --tls-remote option changed.
> That broke more configurations than anticipated. To not break
> configurations that use --tls-remote with a legacy OpenSSL style DN
> anymore, it is now detected when such a DN is configured. When
> necessary the --compat-names option is then automatically enabled.
>
Ack.

Arne


