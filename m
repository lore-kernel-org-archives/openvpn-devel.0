Message-ID: <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
In-Reply-To: <20210402185720.GS976@...1296...>
References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
Date: Fri, 2 Apr 2021 22:04:46 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Fri, Apr 02, 2021 at 08:35:36PM +0200, Simon Matter wrote:
>> What I'm still wondering is why is compression so dangerous with OpenVPN
>> but not so with things like SSH or SCP?
>
> The problem is adversary-controlled traffic in a VPN tunnel, like
> "you surf on a web site, and there is java script that makes your
> browser send carefully crafted requests while someone looks at your
> VPN tunnel from the outside".
>
> If compression is active, an attacker can see if "the parts of the
> header that he can not see" are similar to "the parts that the java
> script creates", due to compression making the resulting packets
> smaller if sequences are identical.
>
> Supposedly you can use this to steal stuff like session cookies,
> which java script would normally not be able to see.
>
>
> Now, I personally find this all a bit unrealistic in practice - it's
> quite a number of "ifs", and even then, it's unclear if possible in
> practice, or even interesting enough, given the myriard of easier to
> exploit attack vectors.
>
> But it *is* a possible attack, and if weighting "is this a good feature?"
> against maintenance effort and possible security effects, compression
> starts drifting towards the negative side (because most traffic inside
> VPNs is already compressed or encrypted anyway today, so compression won't
> have a big effect).
>
>
> Now, in ssh, you copy files of your own choice.  Compression is useful
> there, if the files are not already compressed.  An attacker won't be
> able to manipulate just *part* of one file, to see if the neighbouring
> 100 bytes are "similar"... so this class of attacks does not exist.
>

To me it seems like you can of course build a scenario where compression
_could_ be a problem some how, but there are certainly many use cases
where it can be considered almost impossible to have your security
weakaned by compression. I mean, there is also the SSH VPN mode with c<n
be used with compression and I've never heard someone saying it's less
secure with compression.

In our case where we connect several subnets via OpenVPN and there goes a
lot of different traffic from dozens of hosts in every location, I still
fail to understand how our security would be impacted by compression?

In the end my only question is is it worth to remove compression from
OpenVPN in the long run, or is this not planned?

Thanks,
Simon


