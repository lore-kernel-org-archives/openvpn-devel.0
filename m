From: Arkadiusz Patyk <areq@...104...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 feature request - fixed-address
Message-ID: <on2p60hbdnhrckn682gmmqfrfordonj4ip@...105...>
References: <20040401100921.GA6102@...104...> <twig.1080836392.43345@...41...>
In-Reply-To: <twig.1080836392.43345@...41...>
MIME-Version: 1.0
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
Date: Thu Apr  1 13:38:11 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>

On Thu, 1 Apr 2004 16:19:52 -0000, you wrote:

>Arkadiusz Patyk <areq@...104...> said:
>> ifconfig-pool is fine, but I would need an option for IP
>> reservation for users.
>> The reservation could be realized on thebase of x509name
>> for example:
>> fixed-address 10.8.0.46
>/C=PL/ST=NA/O=Dot.net/CN=Maciej.Nowak/emailAddress=m.nowak@...195...
>> fixed-address 10.8.0.50
>/C=PL/ST=NA/O=Dot.net/CN=Zenon.Ptak/emailAddress=z.ptak@...195...
>> 
>> which would guarantee that user X always gets address Y
>> as option fixed-address in dhcpd
>> 
>> The possibility of IP reservation will simplify firewall configuration -
>> espesially if it is installed on other machine than openvpn server.
>
>Yes, I agree that this feature is necessary.  But I'm concerned that making
>options that take an x509 name as a parameter (as you propose with
>'fixed-address' above) might not be general enough.  I think that people are
>going to want the ability to arbitrarily customize the options which are
>pushed back to the client based on the client's x509 name.
>
>What if it were done by scripting?

Nice, it's OK for me. 

>A script would be called with the x509 name, and the script could then
>generate options which would either be executed locally or pushed to the client.
>This would offer more general, programmatic control over customizing the
>tunnel based on the x509 name.

All options ?

-- 
Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org/]
[IRC:areq ICQ:16231667  GG:1383]  [AP3-6BONE] [AP14126-RIPE]

