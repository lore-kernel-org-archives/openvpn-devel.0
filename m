Message-ID: <9b7d0e7b-912d-3daf-db02-8fc99d4f2a43@...1227...>
Date: Fri, 10 Feb 2023 09:28:08 +0100
MIME-Version: 1.0
References: <20230209142248.455120-1-arne@...1227...>
 <CAGyAFMUP-uCrCbQB2u6dOX-MczORL1nmyo9AS5scmTtws6d0Xg@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAGyAFMUP-uCrCbQB2u6dOX-MczORL1nmyo9AS5scmTtws6d0Xg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add 'allow-compression stub-only
 and refuse framing with 'allow-compression no'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net


Am 10.02.2023 um 09:00 schrieb Lev Stipakov:
> Hi,
>
> I found this behavior a bit confusing.
>
> First,
>
> 2023-02-10 09:53:14 us=187000 Options error: Cannot set comp-lzo to
> 'no', allow-compression is set to 'no'
> 2023-02-10 09:53:14 us=187000 OPTIONS IMPORT: compression parms modified
>
> parms->params
>
> but they weren't really modified, weren't they? We haven't applied
> anything because allow-compression is 'no' by default.
>
> Next, we still establish connection with DCO and got broken tunnel.
Yes. This has always been the behaviour with pushed options that the 
client does not accept.
>
> If we know that the tunnel will be broken (we got pushed comp-lzo no),
> shouldn't we bail out?

That is a more general discussion that I would like to do outside of 
this patch. Currently almost nothing that a server pushes will make the 
connection to abort. We can certainly add logic that will make the 
client abort in this cases but that should affect all the other options 
that are being pushed that the client refuses.

Arne


