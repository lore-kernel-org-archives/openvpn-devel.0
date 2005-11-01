Message-ID: <4367A449.8000105@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] pkcs11-protected-authentication not working in
 2.1beta4 ?
References: <43662220.3000807@...486...> <43665747.5000502@...277...> <436739A2.7020702@...486...>
In-Reply-To: <436739A2.7020702@...486...>
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
Date: Tue Nov  1 09:27:53 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Albert Siersema <appie@...486...>
Cc: openvpn-devel@lists.sourceforge.net

Hi!

Albert Siersema wrote:
> Hello Alon,
>>>Using (--)askpass works fine too when connecting with openvpn but
>>
>>Does it also popup PIN dialog?
> 
> No, it reads from stdin which makes it impossible to run openvpn as a
> MSWindows service.

Strange... I don't understand what is the difference between 
the --show-pkcs11-* and the --askpass...
Just to make sure... --show-pkcs11-slots prompt for PIN???

> I was hoping the pkcs11 code would be helpful in that department as using
> the cryptoapi and running as a service won't work. Probably because the
> service runs as System and tries to retrieve it from the wrong cert store.
> Running the service as another user won't help either ?! :-(

But it does!
Use the management interface.
Put the following in your configuration file:

management hold
management 127.0.0.1 8887
management-query-passwords

Now start your service.
Insert your smartcard.
Run "telnet localhost 8887"

Enter the following commands:
hold release
password "XXXX token" pin

I will write a simple perl script that does it for you soon...

Best Regards,
Alon Bar-Lev.

