Message-ID: <4CBC9C8B.6090302@...1299...>
Date: Tue, 19 Oct 2010 08:14:19 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <7a2e6f85bccdf9dc5b9d2a1c05d7bd91.squirrel@...1166...>
	<20101018194332.4f607b78@...1391...>
In-Reply-To: <20101018194332.4f607b78@...1391...>
Subject: Re: [Openvpn-devel] Intelligent OpenVPN service?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

 On 10/19/2010 07:43 AM, Davide Brini wrote:
> Sorry for the silly question, but how do you expect the OpenVPN link to be
> established if the computer "does not already have a connection"?
>
> What do you mean with the above statement?
I think he means: if the machine is on the corporate network, then don't
kick off an openvpn connection to the corporate network

We did that here using firewall trickery. We block access to the openvpn
server ports from the corporate network - that way openvpn can remain
permanently running on all clients, and it will only work when clients
connect from non-corporate networks.

It's a kludge (hard to scale when you have dozens of corporate Internet
address ranges) - what's really needed is a "--pre-connection" option -
so that we can run scripts before the openvpn service even starts. Then
the "pre" script could explicitly check if the corporate network is
available (eg attempt to download a HTTPS page from an exclusively
internal server) and error if it is - causing openvpn to not attempt to
make a connection

See "2.1 client - how to autorun script post-connect" for further
comments about why I think a "pre" script option would be a good idea.

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


