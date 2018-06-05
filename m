MIME-Version: 1.0
In-Reply-To: <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 5 Jun 2018 13:30:35 -0400
Message-ID: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Jun 5, 2018 at 12:22 PM, Antonio Quartulli <a@...2181...> wrote:
> Hi,
>
> On 05/06/18 23:54, Selva Nair wrote:
> [cut]
>>> ACK on the feature, but NAK on "we can do this more nicely" reasons :-)
>>>
>>> First, I'd leave off the bits about "this can be useful" of the commit
>>> message - because that's not the point of this patch, you can *ignore*
>>> the settings already today.    Maybe word this
>>>
>>>   "This patch enables the client to run IPv6-only on the tun/tap interface,
>>>    but will not make it ignore a pushed IPv4 config.  To achieve that, one
>>>    can use 'pull-filter ignore "ifconfig "' on the client or 'push-filter' on
>>>    the server".
>>>
>>> (if we want to go into this here at all)
>>
>>
>> I don't think this belongs here and such advice could include other
>> details like what
>> to do with routes, redirect gateway etc. Better add it to the howto.
>>
>
> Agreed to both comments. I'll trim the commit and make it more objective.
>
>> A more serious thing:
>>
>> - On windows we require that ifconfig is required with --dev tun. This
>> has to change. Could be tricky as TAP_WIN_IOCTL_CONFIG_TUN requires a
>> v4 address.
>
> Is 0.0.0.0 a valid address for this ioctl?

I do not know the tapdriver code enough to answer that.. -- will take a look.

> Or does it need to be meaningful?
> I think this could be tested by applying only this patch and ignoring
> the pushed 'ifconfig ' directive (as explained in the commit).

I haven't tested it, but pretty sure that'll just fail with "--dev tun
also requires ifconfig" or some such message as can be seen from
open_tun() code in tun.c -- it requires did_ifconfig_setup == true
which won't get set in init_tun if there are no ifconfig parameters.

How to work around that depends on what the tap driver expects in the
v4 address. Ideally, we should patch the driver to work without a V4
address...

Selva

