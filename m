Message-ID: <55CB0CD5.2050405@...1227...>
Date: Wed, 12 Aug 2015 11:07:33 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <55CA09E0.3020503@...2052...> <55CA0FDC.6020004@...1227...>
	<55CB0488.2070708@...2052...>
In-Reply-To: <55CB0488.2070708@...2052...>
Subject: Re: [Openvpn-devel] SRV record support
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
To: Gergely Czuczy <gergely.czuczy@...2052...>, openvpn-devel@lists.sourceforge.net



Am 12.08.15 um 10:32 schrieb Gergely Czuczy:
>
>
> On 2015-08-11 17:08, Arne Schwabe wrote:
>>
>> Am 11.08.15 um 16:42 schrieb Gergely Czuczy:
>>> Hello,
>>>
>>> I would like to ask some help, I'm looking at the OpenVPN source tree
>>> from GitHub as I would like to see how much effort would it be me to
>>> add
>>> SRV record support, as it has increasing demand these days (and really
>>> makes sense, especially for enterprises).
>>>
>>> So, the question is, what would be the best place to hook up the
>>> support
>>> for SRV records?
>>> SRV record mechanism/requirements are the following:
>>>    - It's protocol-specific, so at lookup time it has to be known
>>> whether
>>> it's for UDP or TCP
>> If proto were optional that would fit OpenVPN better. But SRV records
>> seem not support that.
> As Gert already pointed out, this is not that hard. To his comments I
> would like to add mine.
> Personally I think that it's fairly rare when someone has the same
> OpenVPN service on both UDP and TCP
> active (AFAIK this kind of configuration is not even supported by the
> config). Therefore the mechanism can
> check the existence of both kind of SRV records, for-just-in-case
> define a priority order for the protocols,
> then handle the found SRV record by that.

It is often used in this way:

remote foo.bar 1194 udp
remote foo.bar 53 udp
remote foo.bar 1194 tcp
remote foo.bar 443 tcp
>> Doing a one reordering after priority and doing a weighted randomizing
>> between connections with same priority should not be a problem.
> Personally I'm thinking about having the SRV record mechanism up a
> level of the normal
> connection lookup mechanism. The current way you've describe makes
> total sense, and that
> kind of functionality is still totally valid for every address
> produced by the SRV mechanism.
>
> So I'm thinking along the lines a good place to hook it would be where
> the current connection
> mechanism is called, and replace that call with the SRV lookups
> mechanism. So, instead of just
> connecting to the address in the configuration file, check for SRV
> records, if they exist then do
> the SRV logic, if there's no SRV record found, then proceed as it's
> currently being done.
>
> With pseudo-code (without actually quoting the source, so naming
> convention doesn't match):
> Instead of:
>   ovpn_connect(args)
> Do:
>  srv = get_srv_records(host, proto)
> if ( srv ) {
>   // the weight-prio algorithm calling ovpn_connect(srv_specific_args)
> for each of its targets
> } else {
>  ovpn_connect(args); // same as before
> }

That's cute. I think you vastly underestimate the complexity of the
state machine here. Take a look at next_connection_entry in init.c for
the actual code. Part of the problem is that currently in that stage
we do not resolve and have no real way of dealing with errors. So
without complete refactoring, the only way to realize this is to have
special SRV connections that only resolve and then add new temporary
connections in the list after their own entry.

Arne

