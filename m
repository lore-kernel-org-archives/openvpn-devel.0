Message-ID: <534EFC3C.7010503@...1856...>
Date: Wed, 16 Apr 2014 23:55:08 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1397663021-18815-1-git-send-email-davids@...1347...>
In-Reply-To: <1397663021-18815-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Improve error reporting on file access
 to --client-config-dir and --ccd-exclusive
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

Hi,

On 16-04-14 17:43, davids@...1347... wrote:
> When a client connects, the test_file() function is used to check if a client
> config file has been prepared.  And if not, it continues without trying to read
> it.  So, if the privileges of the running OpenVPN process is not allowed to
> open and read an existing file, OpenVPN will treat this as a non-existing file
> without saying anything.  This is clearly wrong.  So this patch adds an warning
> message in the OpenVPN log if it could not open the file due to lack of
> permissions.

Makes sense. Feature ACK.

> This will work fine on all *nix based OSes.  Windows however reports 'no such
> file or directory' (errno=2/-ENOENT) even on privilege access errors when the
> directory this file resides is too restrictive.  But there is no easy way to
> work around that.  However, I believe that the initial sanity checking at
> startup will catch that one, as it will check if the directories it needs
> exists.

I see you're using errno for Windows builds. OpenVPN also has
openvpn_errno(), which expands to errno on *nix OSes, but to
GetLastError() for Windows. I'm not familiar with the details, but maybe
using openvpn_errno() fixes the Windows ENOENT?

-Steffan

