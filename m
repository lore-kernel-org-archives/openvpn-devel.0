MIME-Version: 1.0
Sender: kubec.daniel@...277...
In-Reply-To: <20150306184547.GY21893@...1296...>
References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
	<20150223161832.GN8134@...1296...>
	<54EB5549.9050108@...1114...> <54EE4F19.1000108@...1856...>
	<CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
	<20150306184547.GY21893@...1296...>
Date: Mon, 9 Mar 2015 19:26:28 +0100
Message-ID: <CAEW7GUsx5JrASMJK1EnWaBRUwbv4jMx82-Sh8t=3b5HU73UEhA@...278...>
From: daniel kubec <niel@...1898...>
Subject: Re: [Openvpn-devel] Add support for Keying Material Exporter [RFC
	5705]
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
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

There are alot of different use-cases for this standard mechanism and
I really thinkin about better explanation in general.
I think that some real example will help alot but it requires alot of
client+server code of different protocols (so many of do this and
that).

When you got authenticated VPN then you dont need for example to
discomfort users with username/password in protocols on top of VPN
(Kerberos, HTTP(s), ...)
and you can automatically authenticate "(SSO)" these layers using this
exported keying material [RFC-5705].

It is actually well defines mechanism for "crypto/authentication"
plugin developers and they should know what they are doing.

Maybe Let's try to discuss that using IRC.

Daniel

On 6 March 2015 at 19:45, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Mar 02, 2015 at 01:03:38AM +0100, daniel kubec wrote:
>> Added 2 patches related to [RFC-5705] (code + docs).
>
> Thanks.  TBH, this is all very nice and dandy, but it still doesn't
> make much sense to me...
>
> Some more real-worldish specific examples ("do *this* and *that*, and then
> this mechanisms helps you to achive *this* goal!") instead of links to
> very theoretic documents was more what I had in mind.
>
> The text itself is not bad, but it's still way to crypto-self-centric -
> if you can explain this to someone who doesn't know crypto but wants to
> use that feature for something cool, then you've achieved the goal.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

