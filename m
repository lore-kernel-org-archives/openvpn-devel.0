Subject: Re: [Openvpn-devel] Many to one TCP question
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1083125623.29541@...41...>
In-Reply-To: <408EDB17.8090204@...203...>
References: <twig.1083092616.79848@...41...>, <twig.1083092616.79848@...41...>
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
Date: Tue Apr 27 21:14:01 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lonnie Cumberland <lonnie@...203...>, James Yonan <jim@...41...>, Openvpn-devel@lists.sourceforge.net

Lonnie Cumberland <lonnie@...203...> said:

> Thanks for replying to my posting on this matter as I am still trying to 
> get clear understanding as to the advantages/disadvantages of using 
> TCP/UDP protocals.
> 
> My guess is that most things are done via TCP over the Internet and I 
> seem to remember that there are supposed to be many problems with trying 
> to use UDP over the Internet because of firewalls, bridges and the like, 
> or something like that.
> 
> Also, is it true that you cannot bridge with UDP connections for road 
> warriors with Windows (OpenVPN) machines wishing to connect to Linux 
> (OpenVPN) machines and servers?

No, you should have no trouble bridging with UDP.

> I could be totally off base here, but it UDP protos would work then I 
> could go along that route instead for my project which needs to also 
> scale to a (potentially maybe) very large number of road wariors.

In general UDP is much more scalable when dealing with a large number of
connections.

James


