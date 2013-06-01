From: Josh Cepek <josh.cepek@...1085...>
Date: Sat, 01 Jun 2013 15:11:42 -0500
Message-ID: <kodkhr$583$1@...1062...>
References: <51A244FC.5050700@...1030...> <51A8D993.4050309@...1030...>
Mime-Version: 1.0
In-Reply-To: <51A8D993.4050309@...1030...>
Subject: Re: [Openvpn-devel] key-method <m> parameter
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
To: openvpn-devel@lists.sourceforge.net

On 5/31/2013 12:10, Dash Four wrote:
> Anyone care to clarify this?

You didn't get a reply before because the openvpn-devel list is for
development of openvpn, not support for openvpn. If you're not
submitting a source patch or discussing programming practices, you
usually get ignored. Please direct follow-ups to the openvpn-users list.

> Dash Four wrote:
>> In the manual pages, this parameter is described to have 2 different
>> values - 1 (default for OpenVPN 1.x) and 2 (default for OpenVPN 2.0),
>> but it is not clear:
>>
>> 1. What are the other possibilities for this parameter value, if any
>> exist; and
>> 2. What is the default value of this parameter in the current OpenVPN
>> version (v2.3)
>>
>> So any help in that respect (and properly updated man pages describing
>> this) would be appreciated, thanks.

The manpage is up to date. Maybe the phrase "starting with OpenVPN 2.0"
could clear your confusion up. There are no other options for this
value. key-method 1 is the old symmetric key negotiation method, while
version 2 (used in all the 2.x series) is closer to the TLS model by
taking PRNG-generated bits from both clients to set up the PSK for the
data channel through a TLS PRF. And that's all described in the existing
manpage under that option.

Thus, you only ever want key-method 1 if you're trying to make 2.x talk
to 1.x

--
Josh


