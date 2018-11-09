From: Jon Kunkee <jkunkee@...2393...>
Date: Fri, 9 Nov 2018 19:30:35 +0000
Message-ID: <MW2PR2101MB11153BA1EA7308C85FECE6E2B0C60@...2437...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-2-simon@...2293...>
 <DM5PR2101MB111211D7100DDFB6CF7741C2B0C50@...2412...>
 <99D61A626FDA8A4B90A270669121BE1099363F69@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1099363F69@...2294...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/5] Prevent __stdcall name mangling of
 MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Jon,

>> This approach keeps 'goes in DLL' next to the function itself, which I
>> like.
>
> It's ugly but it keeps both building systems happy and produces consisten=
t=20
> DLL file.

Fantastic. I'm sorry there isn't a more elegant solution, but I'm glad ther=
e's
something that works.

> I had to pick my poison, and I choose to fix issues as close to the source
> as possible.

Understood. Thanks for the explanation.

Samuli, LGTM.

Jon


