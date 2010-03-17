From: Davide Brini <dave_br@...1278...>
Date: Wed, 17 Mar 2010 23:06:45 +0000
References: <1268855205316802500@...1315...>
	<201003172238.23604.dave_br@...1278...>
	<1268866484706506500@...1315...>
In-Reply-To: <1268866484706506500@...1315...>
MIME-Version: 1.0
Message-Id: <201003172306.45567.dave_br@...1278...>
Subject: Re: [Openvpn-devel] Bytecount Reporting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Wednesday 17 March 2010, openvpn@...1315... wrote:
> Hi Davide,
> 
> 
> 
> Yes, that makes sense - and I was going to do that originally, but I
>  figured the real-time bytecount would result in less traffic (and text
>  parsing). One question though ... you say "status file". Do you really
>  mean a file? I can execute the status command over the Management
>  Interface, but it's really a telnet type response, not in a file.

Yes, it's a real file. For example, you say

status /var/run/openvpn.status 10

and here's an example of what you get there (updated every 10 seconds, as per 
the above directive):

# cat /var/run/openvpn.status
OpenVPN CLIENT LIST
Updated,Wed Mar 17 22:56:47 2010
Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since
CLIENT2,78.X.X.X:37298,742906,512337,Wed Mar 17 18:11:44 2010
DHOME,81.X.X.X:52424,3746,4900,Wed Mar 17 22:56:29 2010
ROUTING TABLE
Virtual Address,Common Name,Real Address,Last Ref
10.180.0.4,CLIENT2,78.X.X.X:37298,Wed Mar 17 18:11:45 2010
10.180.0.9,DHOME,81.X.X.X:52424,Wed Mar 17 22:56:30 2010
GLOBAL STATS
Max bcast/mcast queue length,0
END

Easily parsable with sed/awk/perl/whatever you like.
You can even choose among three different formats (all easily parsable) by 
using the "--status-version [n]" option (the above is format 1). See the man 
for the details.

-- 
D.

