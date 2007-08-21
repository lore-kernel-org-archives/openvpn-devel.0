Message-ID: <6c18a4f0708211015i47be47bw1041f3908b14816e@...278...>
Date: Tue, 21 Aug 2007 19:15:04 +0200
From: "Bernd Bartmann" <bernd.bartmann@...277...>
In-Reply-To: <46CB1C67.2080002@...41...>
MIME-Version: 1.0
References: <6c18a4f0705301137q3c63230en25dbd69f9b2f4061@...278...>
	<46CB1C67.2080002@...41...>
Subject: Re: [Openvpn-devel] Possible bug in OpenVPN-2.0.9
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
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net

On 8/21/07, James Yonan wrote:
> I am wondering why the SElinux warnings only occur when OpenVPN is
> started at boot-up.  OpenVPN's behavior with respect to touching things
> that might trigger SELinux errors shouldn't significantly change whether
> or not it is started on boot-up or later.
>
> It would be nice if SELinux would produce more useful debug information
> such as stack trace (that could be gleaned by looking at the userspace
> stack and debug info from gcc -g) or at least indicate if the problem is
> in a shared object that's dynamically linked with OpenVPN at run time.
> As it is, I'm not aware of any reason why OpenVPN would need stack
> execution permission.

How can we debug this further? It would be good to get rid of any
SElinux warnings / error messages. May be this comes from a still
hidden buffer overrun problem so that code placed on the stack?

Best regards,
Bernd.

