Message-ID: <23d6cf00-c932-e663-91a3-921a2b903970@...2108...>
Date: Mon, 9 Dec 2024 15:03:12 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <CAH+fs=-Ng0RGzX3E5d9Q9HUEci8DYDEDVSK3V15tjXbWCepdfA@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <CAH+fs=-Ng0RGzX3E5d9Q9HUEci8DYDEDVSK3V15tjXbWCepdfA@...278...>
Subject: Re: [Openvpn-devel] spelling errors
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
To: Marc Leeman <marc.leeman@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 06/12/2024 10:35, Marc Leeman wrote:
> FYI
> 
> While preparing a package for debian, lintian complained about some
> spelling errors. I had a quick look, but since some are signals (e.g.
> succeded), I didn't want to meddle with them atm.
> 
> I: openvpn3-client: spelling-error-in-binary Configration
> Configuration [usr/libexec/openvpn3-linux/openvpn3-service-configmgr]
> I: openvpn3-client: spelling-error-in-binary nam name
> [usr/libexec/openvpn3-linux/openvpn3-service-backendstart]
> I: openvpn3-client: spelling-error-in-binary occured occurred
> [usr/libexec/openvpn3-linux/openvpn3-service-client]
> I: openvpn3-client: spelling-error-in-binary recieved received
> [usr/libexec/openvpn3-linux/openvpn3-service-sessionmgr]
> I: openvpn3-client: spelling-error-in-binary succeded succeeded
> [usr/libexec/openvpn3-linux/openvpn3-service-netcfg]
> I: openvpn3-client: spelling-error-in-binary unkown unknown
> [usr/sbin/openvpn3-admin]
> I: openvpn3-client: typo-in-manual-page "allows to" "allows one to"
> [usr/share/man/man1/openvpn3-config-manage.1.gz:41]
> I: openvpn3-client: typo-in-manual-page reponsible responsible
> [usr/share/man/man8/openvpn3-service-devposture.8.gz:42]
> 

Thanks a lot.  All but the 'nam' spellings has been resolved.  I was not 
able to locate the 'nam' spelling anywhere.  If this continue to appear, 
we need to figure out which object file this comes from.

commit 6b16d119810b0cec66fab1afa79c33ecb6c73234
Author: David Sommerseth
Date:   Mon Dec 9 14:34:24 2024 +0100

     spelling: Fix various spelling mistakes

     Most of these was reported by Marc Leeman during Debian packaging.

     Reported-by: Marc Leeman
     Signed-off-by: David Sommerseth

<https://codeberg.org/OpenVPN/openvpn3-linux/commit/6b16d119810b0cec66fab1afa79c33ecb6c73234>



-- 
kind regards,

David Sommerseth
OpenVPN Inc



