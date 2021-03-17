References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
 <50c23608-1b71-1651-fa4e-af0d39aba7b3@...2525...>
 <0f47e3c7-f9d2-1649-0fb7-b0b58fa4b84a@...1227...>
 <33d99bf3-96ae-4728-87b2-cc442aa611a4@...2525...>
 <2e1ae5d6-d7bf-9784-689a-b92f51204bda@...1227...>
 <a8c09fa3-8574-7659-5dd0-88321b3f1f12@...2525...>
 <dd3bcfb4-6201-fbbc-fe6d-d9270a04e54e@...2525...>
 <e8a89269-6147-3531-e270-62cc1e5ff10b@...1227...>
 <f35b0880-3fbb-6a6e-e051-147fbcbe2f11@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d5130f4c-ffd2-a0bb-e4fd-77abfc929f5b@...1227...>
Date: Wed, 17 Mar 2021 18:13:04 +0100
MIME-Version: 1.0
In-Reply-To: <f35b0880-3fbb-6a6e-e051-147fbcbe2f11@...2525...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 12.03.21 um 16:12 schrieb Juliusz Sosinowicz:
> Hi Arne,
> 
> I found that the connecting issue is that
> wolfSSL_CTX_set_min_proto_version will fail when the user (in this case
> OpenVPN) tries to set a protocol version that was not compiled in. I
> modified our configure.ac script when building for OpenVPN along with
> some additional fixes in this pull request:
> https://github.com/wolfSSL/wolfssl/pull/3871
> 
> I also found an error in one of OpenVPN's unit tests. I submitted a
> patch for that test in a separate email.

Using an Ed25519 certificate results in

2021-03-17 14:57:23 us=212254 OpenSSL: unknown error number
2021-03-17 14:57:23 us=212262 Cannot load certificate file
/Users/arne/tmp/alice.pem
2021-03-17 14:57:23 us=212265 Exiting due to fatal error


The configure.ac of WolfSSL should be updated to signal EKM support:


AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSSL header
wolfssl/options.h not found!])])
        fi

+     # Wolfssl emulate OpenSSL and has EKM
+       have_export_keying_material="yes"
+
        AC_DEFINE([HAVE_HMAC_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS
since these are defined as macros])
        AC_DEFINE([HAVE_HMAC_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS
since these are defined as macros])
        AC_DEFINE([HAVE_HMAC_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS
since these are defined as macros])

Other than it seem to work in the tests that I threw at it.

I would consider this an ACK. @Gert do you want a new version with the
configure.ac fixed?

Arne


