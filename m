MIME-Version: 1.0
In-Reply-To: <CAEsd45Q2VTHKu8aE0adSPCNRsRTCUCUzfPqj_tWsLQe6XHk1TQ@...278...>
References: <CAEsd45RxJ4Q6kvofngZwkEUBbV3P3fNWTEMc9KksKPOdpB870Q@...278...>
	<CAOazyz3AqvSu05xSDQn=0MX-4QV-mFB1SPNh8SSVL_y3=O5R+g@...278...>
	<CAEsd45Q2VTHKu8aE0adSPCNRsRTCUCUzfPqj_tWsLQe6XHk1TQ@...278...>
Date: Sat, 7 Jul 2012 17:44:20 +0300
Message-ID: <CAOazyz29f5yG19ygoY4y0yTf2GdYTfKsW_bHTkOib2RCQqgKvQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 3.3_alpha2 build problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Sat, Jul 7, 2012 at 5:39 PM, Jonathan K. Bullard <jkbullard@...277...> wrote:
>> Were does the lzo libraries and includes located?
>> If these are not located at default search path of your compiler you
>> should probably add: CFLAGS="-I<location>" LDFLAGS="-L<location>" to
>> configure.
>
>
> Thanks. So the CFLAGS
>
> --with-lzo-headers=../../../$(LZO_DIR)/staging/include
>
> and
>
> --with-lzo-lib=../../../$(LZO_DIR)/staging/lib
>
>
> aren't used by the new build process?
>

Right.
These were none standard, specific to openvpn.
Currently, if you want to specify flags for package you use the
pkg-config format, in this case LZO_CFLAGS and LZO_LIBS.
But there is no reason to do so if you have all dependencies at
/usr/local/*, you can use the CFLAGS and LDFLAGS to modify search
path.

Alon.

