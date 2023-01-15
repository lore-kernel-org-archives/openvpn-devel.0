Message-ID: <8f361fc115ba580d9fc62735b24dd8ebb315f496.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 15 Jan 2023 08:37:00 -0500
In-Reply-To: <44a2128f-2ade-5def-beb1-20fd48d838d2@...1227...>
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <Y8PnGp9Rt/n9FODz@...1296...>
 <7e0167f8-b1d3-a3f7-db40-5a441dba602f@...68...>
 <44a2128f-2ade-5def-beb1-20fd48d838d2@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

On Sun, 2023-01-15 at 14:12 +0100, Arne Schwabe wrote:
> Am 15.01.23 um 14:10 schrieb Matthias Andree:
> > Am 15.01.23 um 12:44 schrieb Gert Doering:
> > > Hi,
> > > 
> > > On Sat, Jan 14, 2023 at 05:28:09PM -0500, James Bottomley wrote:
> > > > What do you mean "a source"? every apache licensed library
> > > > that's statically linked with a GPLv2 program would be an
> > > > example of this ... in the early days there was no dynamic
> > > > linking, so all the early GNU tools were statically linked with
> > > > wodges of proprietary binary gunk.
> > >  
> > > These "early day" precede the creation of the Apache license or
> > > GPLv2 by many years.
> > 
> > Certainly not the GPLv2 (1991). GPLv3 (2007) maybe. This seems to
> > be the oldest converted to Git and reachable from the 2.5 and 2.6
> > carrying branches:
> 
> I think Gert wanted to say that the days before dynamic libraries
> were not invented yet and every was linked statically was well before
> the GPL.

The GNU project began in 1982.  Static libraries for SYS-V were
initially proposed around 1986 and didn't become widespread until the
90s.

James


