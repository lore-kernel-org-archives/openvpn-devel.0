Message-ID: <4823DDBA.8090005@...41...>
Date: Thu, 08 May 2008 23:14:34 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <47ED5E94.4010701@...1085...>
In-Reply-To: <47ED5E94.4010701@...1085...>
Subject: Re: [Openvpn-devel] [patch] Windows --up parameter quoting problem
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
To: Josh Cepek <josh.cepek@...1085...>
Cc: Openvpn-devel@lists.sourceforge.net

Josh Cepek wrote:
> Under Windows, when run_up_down() from misc.c executes the --up 
> script, the position of the parameters depends on the device name of 
> the tun/tap adapter.  For example, a default installation creates a 
> device that may be called "Local Area Connection 2" (number varies), 
> but this device name isn't quoted when passed to the --up program.  
> This makes determining the actual name (or any other parameters for 
> that matter) nearly impossible.
>
> I've attached a patch that quotes the device argument in the 
> run_up_down() function insuring it is always the first argument to the 
> --up script no matter how many spaces appear in the device name.
>


I've merged this patch into the subversion directory for the 2.1 series:

http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/

It will be included in 2.1-rc8.

James


