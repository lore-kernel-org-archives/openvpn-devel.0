MIME-Version: 1.0
In-Reply-To: <CABT9mj96OXMejAXm3bp3SxY-OHespaPV_tdiYcpCk01BoC94xg@...278...>
References: <CABT9mj_+3KRELoLQBGK5B14Q=Y_HGGjS48E6bEWnDPuCwBXgtw@...278...>
	<CAOazyz0zS1WjVrLv1u22ZN+cr18ewuzeZnc-5PrSHjss1Cn=ew@...278...>
	<CABT9mj9Xjs6T_hCA-pcEPUaoCe4ZxZ8-yGHB_MeDReM=wHBa8Q@...278...>
	<CABT9mj96OXMejAXm3bp3SxY-OHespaPV_tdiYcpCk01BoC94xg@...278...>
Date: Tue, 13 Mar 2012 19:51:31 +0200
Message-ID: <CAOazyz1vHGfX-M+h7LEgXDA=1d0f_stRqvH08U9b++5gddWAPg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] mingw32-built openvpn-2.3-alpha1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Athanasios Douitsis <aduitsis@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Mar 13, 2012 at 7:27 PM, Athanasios Douitsis <aduitsis@...277...> w=
rote:
>
> Hi again,
>
> Some more feedback.
>
> 1.Trying to use MSVC2010 (or later I suppose) to build the project using
> the new method outlined in your link, I noticed that 'vcbuild' has been
> removed after vc2008. They recommend using msbuild, whatever that is, whi=
ch
> requires different cli parameters=C2=A0 and also requires that the projec=
t be
> converted accordingly. You may want to note this for future reference. I
> haven't been able to compile, currently trying to find a VC2008 installat=
ion
> to try again.

Thanks!
I will try MSVC2010... need to find time to install that.
However, please note that the mingw is the configuration that is most
flexible and probably be maintained....

>
> 2.Sometimes the script fails to download the parts that are hosted on
> github, I suspect because github emits a 302.

All?
This is strange....
The script tries to redirect by location response header...
Can you please add WScript.Echo(location) after the var location=3D so
we can what we get?
And maybe add WScript.Echo(http.GetAllReponseHeaders());

Thanks!

