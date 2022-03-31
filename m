Message-ID: <3eb8f2b9-41d0-7e4f-c9a9-fef344f0080f@...1227...>
Date: Thu, 31 Mar 2022 12:17:25 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <9564ba11-d626-4e60-fa2f-979c114b95c2@...277...>
 <d18f61d5-3f4d-b6b1-2a57-d2b2ff9b7a25@...2080...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <d18f61d5-3f4d-b6b1-2a57-d2b2ff9b7a25@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> I am willing to work on making the netcfg service even less "OpenVPN 3 
> centric", and it has a potential to grow towards a generic VPN API on 
> Linux.  The current D-Bus interface it uses is highly inspired by the 
> Android VPN API.  But this won't happen in a short time and not in time 
> for the OpenVPN 2.6 release.  This is probably something which is more 
> realistic for OpenVPN 2.8.  But this needs to be discussed more 
> thoroughly (next hackathon?).

The current interface and interface design is ill suited for a server 
and I would even go so far as saying that extending the interface to 
support the full server functionality will go against the goal of the 
interface design.

A limited client mode might work but even that is something were you 
loose features that OpenVPN support in client mode. On platforms like 
ANdroid/iOS were you need to use an API like that you can hand wave that 
away as limitation of the platform but on Linux that is harder.

Also it is a very linux specific solution that will not work on macOS or 
Windows. So we might consider approaches as well.

Arne

