Message-ID: <43C40194.807@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
References: <605203017.20060102170037@...450...> <43B9409E.4090903@...277...> <181840658.20060110042715@...450...> <43C37B3E.1090204@...277...> <758887784.20060110165806@...450...> <43C3C0FE.40009@...277...> <1056907489.20060110185322@...450...>
In-Reply-To: <1056907489.20060110185322@...450...>
Subject: [Openvpn-devel] Re: OpenVPN and eToken (on windows).
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Jan 10 10:51:00 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: mts.spb.suxx@...450..., openvpn-devel@lists.sourceforge.net

mts.spb.suxx@...450... wrote:
> Hello Alon,
> 
> ABL> Sure! I recommend of doing so.
> OK.
> 
> ABL> So as long as private keys cannot be extracted... and as long as
> ABL> the attacker does not have access to the CA private key, you are
> ABL> in a good security level.
> The CA certificate I included on the token *DOES NOT* contain it's
> private key.
> Do you mean the brute-force against CA's public key?

They can simply replace it with a different CA certificate, 
so that you authenticate to a server that claims to be your 
server but actually is a different server that have the same 
certificate name as your server but was issued by the CA 
that replaced your CA on the token.

> 
> ABL> ... if the user can select any openvpn configuration he can alter
> ABL> your network trust and bridge it to unauthorized foreign
> ABL> networks...
> Oh! Yes, now I see!
> 

I am glad!

Best Regards,
Alon Bar-Lev.

