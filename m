Date: Fri, 11 Aug 2017 13:21:47 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20170811102147.GT4090@...1281...>
References: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
Subject: Re: [Openvpn-devel] OVPN Interactive Service for non-admin users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Aug 09, 2017 at 02:31:58PM +0000, Simon Rozman via Openvpn-devel wrote:
>    Hi!
> 
>    I am developing an eduVPN client for Windows. Imagine the eduVPN client as
>    a custom OpenVPN GUI. The client uses openvpn.exe for connecting, the
>    configuration file is provided by eduVPN server once user authenticates
>    using OAuth. User running the eduVPN client is not an administrator.
>    Elevation is out of the question.
> 
> 
>    I would like to use the Interactive Service to start openvpn.exe, but I
>    have some problems:
> 
> 
>    1.       The configuration file is dynamically downloaded by the eduVPN
>    client and stored somewhere user can write (user's temporary folder for
>    example). But the Interactive Service was specifically programmed to allow
>    configurations from "C:\Program Files\OpenVPN\config" folder only. But
>    user running eduVPN client can't write to this folder.
>


Wasn't this changed in the latest version, allowing config files to be under user home/profile directory? 


-- Pasi
 

