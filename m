Date: Mon, 27 Mar 2023 10:45:48 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZCFXvBfob0KajSBd@...2685...>
References: <20230323143140.76949-1-frank@...2641...>
 <d917e295-3c4b-2a72-8ce1-6619dce22879@...68...>
MIME-Version: 1.0
In-Reply-To: <d917e295-3c4b-2a72-8ce1-6619dce22879@...68...>
Subject: Re: [Openvpn-devel] [PATCH] unit_tests: make cert_data.h compile
 with MSVC
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
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Mar 24, 2023 at 07:30:51PM +0100, Matthias Andree wrote:
> Am 23.03.23 um 15:31 schrieb Frank Lichtenheld:
> > Currently this is not obvious since we never build the
> > UTs with MSVC, but it doesn't like the initializers with
> > "const" variables. They cause
> > error C2099: initializer is not a constant
> 
> What MSVC version are you using? What options? I've tried with a minimal
> C program with static const char *const foo = "something"; and it
> compiled with the latest 2017 or 2022 MSVC.
> 
> How are you connecting the unit test to the build?

For reference, this is part of my experimental cmake branch,
https://github.com/flichtenheld/openvpn/tree/cmake

Regards,
-- 
  Frank Lichtenheld

