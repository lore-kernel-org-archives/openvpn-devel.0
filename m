Message-ID: <4B23ECC3.8090904@...41...>
Date: Sat, 12 Dec 2009 12:19:31 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <1256844344.7529.43.camel@...1272...>	<200911122028.07536.dave_br@...1278...>
	<4B21CC61.2020401@...41...> <200912121131.20556.dave_br@...1278...>
In-Reply-To: <200912121131.20556.dave_br@...1278...>
Subject: Re: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

Davide Brini wrote:
> On Friday 11 December 2009, James Yonan wrote:
> 
>> Try adding the "nobind" directive to your client config file.  I think
>> this will solve the problem.
> 
> That seems indeed to do it. Thank you very much!
> 
> However, never in my life could I have imagined that this was due to a setting 
> *on the client*. For single-homed clients, my (possibly wrong) understanding 
> was that using or not using "nobind" would essentially be the same. 
> Since now I'm curious, could you please kindly provide a bit more insight as 
> to *why* using "nobind" on the client fixes it, and how that affects the 
> server?

Using nobind on the client for UDP client connections generates a socket 
with a dynamic source port number.  This is key because it means that 
when the client reconnects, it does so with a new source port number, 
and this allows OpenVPN to detect that the initial UDP packet represents 
a new connection, and is not part of the old connection.

The problem is that when nobind is not used, the source port on the new 
connection is recycled -- it's the same as the old connection.  So when 
OpenVPN sees the connection-initiating packet, after the client switches 
over to the secondary server address, it gets confused because it 
doesn't expect sessions from a given source address to change its 
destination address mid-session.

James


