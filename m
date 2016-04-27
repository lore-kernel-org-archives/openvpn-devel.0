MIME-Version: 1.0
In-Reply-To: <20160427175118.GY53051@...1296...>
References: <1460918143-408-1-git-send-email-steffan@...1856...>
	<57209BDF.4030202@...1227...> <20160427175118.GY53051@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 27 Apr 2016 21:51:08 +0200
Message-ID: <CAA1AbxJbtifDyaDOfUugyRmhM+X0xPoyK3fd-zE7OdQ-OZPPPg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Migrate to mbed TLS 2.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, Apr 27, 2016 at 7:51 PM, Gert Doering <gert@...1296...> wrote:
> While I totally love to just merge stuff other folks have reviewed, this
> patch just doesn't apply to my tree :-( - and the rejects are too many
> to try to mangle by hand.
>
> Patching file configure.ac using Plan A...
> Hunk #1 failed at 291.
> Patching file src/openvpn/options.c using Plan A...
> Hunk #11 failed at 6584.
> Patching file src/openvpn/ssl_verify_polarssl.c using Plan A...
> Hunk #2 failed at 35.
> Hunk #6 failed at 160.
> Hunk #7 failed at 216.
> Hunk #8 failed at 232.
> Hunk #9 failed at 263.
> No such line 417 in input file, ignoring
>
>
> I'm fairly sure I understand why this is happening - Steffan has polar-
> related patches in his tree that have not yet been merged - but "as is",
> I can't merge this...
>
> OTOH, it might apply if we get the James-reworked-by-Steffan patch series
> in...

This should indeed be the case.

-Steffan

