Message-ID: <4B6950FF.6010707@...1294...>
Date: Wed, 03 Feb 2010 11:33:35 +0100
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
References: <4B672F5E.9040106@...1299...> <4B693D43.7060107@...515...>
	<4B69487C.9010907@...1299...>
In-Reply-To: <4B69487C.9010907@...1299...>
Subject: [Openvpn-devel] missing ssleay32.dll
Reply-To: e.lohmann@...1294...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


When I build openvpn.exe it compiles libeay32.dll libssl32.dll and
libpkc11-helper-1.dll
If I try to run the executable I get an error of a missing ssleay32.dll

I can resolve that problem if I copy libssl32.dll to ssleay32.dll

Is that an error in the buildscript or do I anything wrong?

Regards, Eike


Jason Haar schrieb:
> On 02/03/2010 10:09 PM, Samuli Sepp=E4nen wrote:
>=20=20=20
>> Hi Jason,
>>
>> You can file bugs to our SF.net bug tracker:
>>=20=20=20
>>=20=20=20=20=20
>
> Thanks! Done it: 2945154 and 2945147
>
>=20=20=20

