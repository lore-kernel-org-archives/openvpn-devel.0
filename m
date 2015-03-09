MIME-Version: 1.0
Sender: kubec.daniel@...277...
In-Reply-To: <20150309190242.GF21893@...1296...>
References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
	<20150223161832.GN8134@...1296...>
	<54EB5549.9050108@...1114...> <54EE4F19.1000108@...1856...>
	<CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
	<20150306184547.GY21893@...1296...>
	<CAEW7GUsx5JrASMJK1EnWaBRUwbv4jMx82-Sh8t=3b5HU73UEhA@...278...>
	<20150309190242.GF21893@...1296...>
Date: Mon, 9 Mar 2015 20:46:10 +0100
Message-ID: <CAEW7GUvz6gLkj4maQbsbSEFcYRr45yu-U_5RDyGBDsoMDZVvrg@...278...>
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

Hi,

I wanted to discuess (IRC) what exactly I should add to documentation.

It's like adding standard, secure and well defined hash-function for
use by plugins and then there are (N) different use-cases.

"\-keying-material-exporter label len
Save Exported Keying Material [RFC5705] of len bytes using label in environment
(exported_keying_material) for use by plugins in OPENVPN_PLUGIN_TLS_FINAL
callback."

"Keying Material Exporter [RFC-5705] allow additional keying material to be
derived from existing TLS channel. This exported keying material can then be
used for a variety of purposes. TLS allows client and server to establish
keying material for use in the upper layers between the TLS end-points"

It is nothing more then generating same keying material for client and
server plugins (OPENVPN_PLUGIN_TLS_FINAL callback)
without the need of transfer that key throught (D)TLS channel and/or app layer.

Daniel

On 9 March 2015 at 20:02, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Mar 09, 2015 at 07:26:28PM +0100, daniel kubec wrote:
>> It is actually well defines mechanism for "crypto/authentication"
>> plugin developers and they should know what they are doing.
>>
>> Maybe Let's try to discuss that using IRC.
>
> IRC explanation isn't going to help someone who comes across this in
> a few months or years - a good example in the docs would really be
> appreciated.
>
> No code needed.  Just describe the parts that would be needed to make
> this work - like "on the server, you need a plugin that talks to
> foobar service to get a blinkenlight, on the client, you need a plugin
> that uses EKM to make the light blink, via..."
>
> Right now I see crypto that adds code, seems to not break anything, but
> the only reason why the extra code is there is "oh, you can do lots of
> cool things with it" - this should be spelled out better, to make it
> useful to more people.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

