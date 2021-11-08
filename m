Date: Mon, 8 Nov 2021 13:23:47 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <183961674.290978.1636374227246@...2642...>
In-Reply-To: <9bf5fef1-e2e5-4612-5f52-b083e45b2f74@...1227...>
References: <20211107174000.16210-1-frank@...2641...>
 <9bf5fef1-e2e5-4612-5f52-b083e45b2f74@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix error in example firewall.sh script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Adrian <adrian.crespo@...2282...>


> Arne Schwabe <arne@...1227...> hat am 08.11.2021 12:36 geschrieben:
> 
>  
> Am 07.11.21 um 18:40 schrieb Frank Lichtenheld:
> > From: Adrian <adrian.crespo@...2282...>
> > 
> > The man page says:
> > [!] -s, --source address[/mask][,...]
> > 
> > Signed-off-by: Frank Lichtenheld <frank@...2641...>
> > ---
> >   sample/sample-config-files/firewall.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > As part of an initative to clean up the Github PR submissions, submitting
> > this patch to the mailing list for inclusion. Looks obviously correct to
> > me.
> > 
> > diff --git a/sample/sample-config-files/firewall.sh b/sample/sample-config-files/firewall.sh
> > index 19d75ee9..456700ca 100755
> > --- a/sample/sample-config-files/firewall.sh
> > +++ b/sample/sample-config-files/firewall.sh
> > @@ -50,7 +50,7 @@ iptables -A OUTPUT -p tcp --sport 137:139 -o eth0 -j DROP
> >   iptables -A OUTPUT -p udp --sport 137:139 -o eth0 -j DROP
> >   
> >   # Check source address validity on packets going out to internet
> > -iptables -A FORWARD -s ! $PRIVATE -i eth1 -j DROP
> > +iptables -A FORWARD ! -s $PRIVATE -i eth1 -j DROP
> >   
> >   # Allow local loopback
> >   iptables -A INPUT -s $LOOP -j ACCEPT
> > 
> 
> 
> I have a vague idea that this is actually different. Like one is that 
> condition is not fulfilled and the other is that it is not part of the 
> subnet if is different when there is different protocol but I might 
> misremember.

Certainly does not work with my iptables:
# iptables -A OUTPUT -s ! 10.0.0.0/8 -j ACCEPT
Bad argument `10.0.0.0/8'
Try `iptables -h' or 'iptables --help' for more information.
# iptables -A OUTPUT ! -s 10.0.0.0/8 -j ACCEPT
#

Regards,
   Frank

