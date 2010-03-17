Message-ID: <4BA1433A.8090808@...1114...>
Date: Wed, 17 Mar 2010 22:01:46 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268855205316802500@...1315...>
In-Reply-To: <1268855205316802500@...1315...>
Subject: Re: [Openvpn-devel] Bytecount Reporting
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
To: openvpn@...1315...
Cc: openvpn-devel@lists.sourceforge.net

On 17/03/10 20:46, openvpn@...1315... wrote:
> Hi,
> 
> I am trying to write an application that monitors traffic over an OpenVPN link - by using bytecount information from the management interface. However, after I telnet in, and enter "bytecount 1" (for 1 second updates), I find that the real-time bytecount updates are not really every second. They seem to be initially, but soon slow down (to an update every 5-10 seconds).
> 
> Is this expected, or a known issue?

Hi,

I'd say this is probably unexpected.  But I'd like to know a little bit
more about your setup.  What kind of OS are you running OpenVPN?

It sounds like your OpenVPN process get lower priority somehow.  But it
could also be that it is dependent on the amount of traffic passing over
the tunnel.  I'll dig more into the code to see if there are some
oddities there before concluding.


kind regards,

David Sommerseth

