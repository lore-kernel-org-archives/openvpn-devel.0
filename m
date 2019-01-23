References: <20180228231123.27782-1-steffan@...1856...>
 <20180304090817.GL69387@...1296...>
 <1999112e-8de3-5ac2-e9a2-0f499e69b123@...1856...>
 <87muznkdzr.fsf@...2274...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <59431ed4-01b9-e0f8-87a0-7e58c758e816@...1227...>
Date: Wed, 23 Jan 2019 10:30:22 +0100
MIME-Version: 1.0
In-Reply-To: <87muznkdzr.fsf@...2274...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Add a warning that we do not officially
 support LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jeremie Courreges-Anglas <jca@...2272...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> I considered that (modulo the sleep 60) and wrote the code to do the
>> configure check, but then thought that a not-suppressible warning in the
>> logs would be sufficient.  I still think it is, but don't mind re-adding
>> it to configure.ac if you prefer that.
> 
> As an OpenBSD developer and the maintainer of our OpenVPN port,
> I certainly care about building and using OpenVPN with LibreSSL.
> I have already provided patches in the past, and yesterday I pushed
> compat glue in LibreSSL so that openvpn-2.4.5 can build on OpenBSD
> (-current).
> 
> So I'm wondering what would be needed to consider LibreSSL "supported".
> 
> I hear that there are concerns over LibreSSL not being API-compatible
> with OpenSSL.  As you may have noticed, LibreSSL recently introduced
> lots of OpenSSL-1.1+ interfaces.  While there is no plan to support the
> full OpenSSL-1.1 API (tons of functions were added, not all of them seem
> useful...), the intent is to provide what the ecosystem actually needs.
> I can probably serve as a bridge between the two projects here.
> 
> If you see other points where I - or anyone else - can help, please
> share. :)
>

With my recent commits that use more OpenSSL 1.1.1 features building
with LibreSSL breaks again since it claims to be OpenSSL 2.0 or
something ridiculous like that. In my book claiming to support APIs you
don't even know is a bad move.

With the current situation I would also ACK this patch. I see no good
way at the moment for supporting LibreSSL.

Arne

