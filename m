Message-ID: <162176b7-0c99-6ba0-20f9-cc9a7e8b706b@...2108...>
Date: Mon, 9 Dec 2024 15:04:53 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <CAH+fs=9t5VvejtnxVFTCS8zVjM54HQaXw_bowXLmnr_r3PDJAg@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <CAH+fs=9t5VvejtnxVFTCS8zVjM54HQaXw_bowXLmnr_r3PDJAg@...278...>
Subject: Re: [Openvpn-devel] SystemD user names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Marc Leeman <marc.leeman@...277...>, openvpn-devel@lists.sourceforge.net

On 06/12/2024 10:29, Marc Leeman wrote:
> David,
> 
> cf. att.
> 
Thanks a lot!  Patch has been committed.

commit 9a1cf3fae9fb3788e9714d148d9b7efcb5f4c948
Author: Marc Leeman
Date:   Fri Dec 6 10:29:19 2024 +0100

     build: Fix incorrect OPENVPN_USERNAME in D-Bus autostart files
     
     Remove hard coded `openvpn` user in meson files.  The build system
     allows to replace the default `openvpn` user with some other name.
     This works for most services, but during refactoring, 3 hard coded
     references were omitted.
     
     This popped up while packaging for Debian since the system users should
      be prepended with a '_'.
     
     Signed-off-by: Marc Leeman
     Approved-by: David Sommerseth

<https://codeberg.org/OpenVPN/openvpn3-linux/commit/9a1cf3fae9fb3788e9714d148d9b7efcb5f4c948>


-- 
kind regards,

David Sommerseth
OpenVPN Inc



