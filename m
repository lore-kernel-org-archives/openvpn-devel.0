References: <1475055231-1778-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0351c1fa-1afe-e779-1cc9-1eb6b601fb57@...1227...>
Date: Wed, 28 Sep 2016 12:18:57 +0200
MIME-Version: 1.0
In-Reply-To: <1475055231-1778-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Make sure options->ciphername and
 options->authname are always defined
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


Am 28.09.16 um 11:33 schrieb Steffan Karger:
> The NCP code does a strcmp(options->ciphername, ...) without first checking
> whether options->ciphername is NULL.  This could cause a crash when using
> "--cipher none".  This patch fixes that problem by ensuring that
> options->ciphername (and options->authname) are never NULL.  Ensuring that
> options->ciphername is never null prevents us from having to write null
> checks everywhere.
>
ACK from me. It also fixes my test setup to reproduce the bug.

Arne

