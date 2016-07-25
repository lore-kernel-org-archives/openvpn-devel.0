MIME-Version: 1.0
In-Reply-To: <20160725200452.GE78279@...1296...>
References: <20160725200452.GE78279@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 25 Jul 2016 22:11:06 +0200
Message-ID: <CAA1AbxKbdwmAJKzxk6YvSJKFpD1XJ5VPTne230c1R59RjVO70w@...278...>
Subject: Re: [Openvpn-devel] use of --cipher with no arguments?
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

On Mon, Jul 25, 2016 at 10:04 PM, Gert Doering <gert@...1296...> wrote:
> has anyone ever used "--cipher" without an argument?  If yes, what is the
> intended usage?  It sort of "tells openvpn we want crypto!" but does not
> go into detail about it...
>
> Normally, this would just be a random weird option, but I ran across
>
>   --cipher none --cipher
>
> which first tells openvpn "nah, we do not want anything!" and sets
> a pointer to NULL, and then tells openvpn "but please *do* use the
> ciphers already setup!", which core dumps.
>
> This is not remotely exploitable, so not a *security* issue, but a bit
> stupid nonetheless - so I propose we just throw out "--cipher" with
> no arguments (--cipher none, or --cipher bf-cbc would, of course,
> continue to work).
>
> Anyone having a good argument against it?  JJK, do you happen to know
> what this is about?

As the patch I just sent suggests, I don't believe this can be useful at all.

Using just --cipher is a no-op if anything but '--cipher none' is used
(o->ciphername_defined is already set to true), and crashes OpenVPN
otherwise.  Probably just a leftover 'from the old days'.

-Steffan

