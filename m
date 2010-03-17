From: Davide Brini <dave_br@...1278...>
Date: Wed, 17 Mar 2010 22:38:23 +0000
References: <1268855205316802500@...1315...>
In-Reply-To: <1268855205316802500@...1315...>
MIME-Version: 1.0
Message-Id: <201003172238.23604.dave_br@...1278...>
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
 
> I am trying to write an application that monitors traffic over an OpenVPN
>  link - by using bytecount information from the management interface.
>  However, after I telnet in, and enter "bytecount 1" (for 1 second
>  updates), I find that the real-time bytecount updates are not really every
>  second. They seem to be initially, but soon slow down (to an update every
>  5-10 seconds).

Sorry for avoiding a direct answer to the question (David has already 
addressed that quite well), but I just wanted to tell you that you can get 
byte counts from OpenVPN's status file, ie the one you specify with "--
status". I used that in the past to monitor clients and traffic (it was 
actually a Munin plugin that read the file and collected the data).
That said, it might not suit your requirements, but I thought I mentioned that 
just in case.

-- 
D.

