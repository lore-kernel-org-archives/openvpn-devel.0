MIME-Version: 1.0
References: <CAKuzo_jUJ58K5VirzjgvP=dJZ_qy+H0gGzNJ4hkiAyjSKQdMUQ@...278...>
 <705d349f-2f0c-016c-914a-6d52e512fc20@...2080...>
In-Reply-To: <705d349f-2f0c-016c-914a-6d52e512fc20@...2080...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 29 Jan 2021 09:38:58 +0200
Message-ID: <CAGyAFMXgyX74FY1EgrebE65opcWfMUJif5ndhYVNjUfhpKNYEw@...278...>
Subject: Re: [Openvpn-devel] rfc: mingw and the interactive service code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> > Any thoughts? I'm leaning towards option (ii).
>
> Agreed!  Option (ii) sounds most reasonable to me too.

According to https://docs.microsoft.com/en-us/cpp/c-runtime-library/format-specification-syntax-printf-and-wprintf-functions?view=msvc-160#flags
VisualStudio is perfectly fine with %hs and %ls.

> An hs or hS type specifier is synonymous with s in printf functions and with S in wprintf functions. An ls, lS, ws, or wS type specifier is synonymous with S in printf functions and with s in wprintf functions.

Vote for (ii).

-- 
-Lev

