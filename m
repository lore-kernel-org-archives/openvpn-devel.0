Message-ID: <91859bbb-a689-8884-af2a-58918cacd2c3@...1227...>
Date: Thu, 29 Jun 2023 13:43:50 +0300
MIME-Version: 1.0
From: Arne Schwabe <arne@...1227...>
References: <20230629103953.3238575-1-arne@...1227...>
Content-Language: en-GB
In-Reply-To: <20230629103953.3238575-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] [CMake] Only add
 -Wno-stringop-truncation on supported compilers
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
To: openvpn-devel@lists.sourceforge.net

Am 29.06.23 um 13:39 schrieb Arne Schwabe:
> The -Wno-stringop-truncation flag is only supported by some GCC versions
> and not by Clang (macOS, FreeBSD) at all.
> 
> Change-Id: I452bc4ee935d13f8e9095d0a31805a3bbaff0cec


Ingore this version.


