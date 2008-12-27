Message-ID: <4956551D.7030700@...1148...>
Date: Sat, 27 Dec 2008 17:17:33 +0100
From: Morten Christensen <mc-openvpn@...1148...>
MIME-Version: 1.0
References: <48F11865.5080903@...1135...> <491F4441.7080109@...1148...>	
	<495628C0.7060405@...1135...>
	<9e0cf0bf0812270738s2a248adcx6967116ee58e1edd@...278...>
In-Reply-To: <9e0cf0bf0812270738s2a248adcx6967116ee58e1edd@...278...>
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Alon Bar-Lev skrev den 27-12-2008 16:38:
> On Sat, Dec 27, 2008 at 3:08 PM, Jochen Wierum <jochen@...1135...> wrote:
>   
>> What is not implemented - and perhaps will never be - is the possibility
>> to extract the username out of the CN field of the certificate, because
>> the management interface doesn't provide functions to read these data.
>>     
>
> I don't understand... What is missing? Isn't this feature is important
> at server side, while the UI runs on the client side?
>   
It is a feature-request and not a requirement or a bug.

In my seup we use auth-user-pass and the username is allways the same as 
the CN of the certificate.

Auth-user-pass requires, that we enter both username and password each 
time we start a connection. When we know that the username is on the 
system in the CN-field of the certificate, it will be nice not to be 
forced to enter it on every connection.


--
Morten Christensen

