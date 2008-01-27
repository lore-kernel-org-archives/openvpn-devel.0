From: "Dave" <dev@...575...>
Date: Sun, 27 Jan 2008 11:04:01 -0600
Message-ID: <000001c86106$9dc87fc0$16ada8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0801262257k735616a6r6f0931e4ae5f4e1a@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Alon Bar-Lev' <alon.barlev@...277...>, 'James Yonan' <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

I would, but I cannot figure out how to map the old options to the current
options.  Previously, I used:


#basic token selection
pkcs11-providers bt_csp11.dll
pkcs11-slot-type "label"
pkcs11-slot "DavidLemley"

pkcs11-sign-mode sign

#select token keyset
pkcs11-id-type label
pkcs11-id "david_lemley_bestoken's ziggurat29 CA ID"

Can you explain the new options, or point me to where they are explained so
I can reconfigure?


> -----Original Message-----
> From: openvpn-users-bounces@lists.sourceforge.net 
> [mailto:openvpn-users-bounces@lists.sourceforge.net] On 
> Behalf Of Alon Bar-Lev
> Sent: Sunday, January 27, 2008 12:58 AM
> To: James Yonan
> Cc: Openvpn-devel@lists.sourceforge.net; 
> openvpn-users@lists.sourceforge.net
> Subject: Re: [Openvpn-users] OpenVPN 2.1-rc5 released
> 
> 
> Can anyone who uses PKCS#11 on Windows can acknowledge it works?
> 
> Thanks!
> 
> On 1/24/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> > All PKCS#11 users, please notice,
> > There was a major change in the parameters of PKCS#11, 
> please refer to 
> > the HOWTO: http://openvpn.net/howto.html#pkcs11
> >
> > Regards,
> > Alon Bar-Lev.
> 
> --------------------------------------------------------------
> -----------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008. 
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
> 


