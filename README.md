# RW-API

```v1.0.0```

<br>

## 소개

FiveM, 개발관련, 기타 타 게임 등의 유용한 API들로 구성될 예정이며, API는 지속적으로 추가될 예정입니다.<br>
현재 구성된 API 목록을 아래와 같습니다.<br><br>

- Obfuscate API: FiveM Lua난독화 API (현재 이용가능)<br>
- Pay API: 리얼페이 API (현재 이용가능)<br>
- Game API: 리얼월드 2022 (FiveM) 유저 및 컨텐츠 API (리얼월드 2022 오픈 후 이용가능)<br>

<br>

- config.json 설정

```json
{
  "apiNode": "https://api.realw.kr", // API 노드
  "apiUrls": {
    "pay": "/cp/v1", // Pay API 엔드포인트
    "obfuscate": "/obfuscate/v1", // Obfuscate API 엔드포인트
    "game": "/game/v1" // Game API 엔드포인트
  },
  "apiKey": "[리얼월드API키]"
}
```

<br>

## 사용 방법

1. `리얼월드API키` 를 리얼월드 파트너 커뮤니티 `FM커뮤니티` 에서 발급 받습니다.
2. RW-API 를 로컬에 다운 받습니다. `config.json` 의 `apiKey` 필드에 발급받은 `리얼월드API키`를 설정합니다.
3. 사용할 리소스에 `RWAPI/lib/RWAPI.lua` 파일을 추가한 후 API를 호출할 수 있습니다.

(사용 예제는 fivem-lua/RWAPI-Example 을 참조 바랍니다.)

<br>

## 설정 (config.json)

<table>
<tr>
<td>값이름</td>
<td>타입</td>
<td>설명</td>
</tr>
  <tr>
    <td>apiNode</td>
    <td>STRING</td>
    <td>API 노드 URL 입니다.</td>
  </tr>
  <tr>
    <td>apiUrls</td>
    <td>OBJECT</td>
    <td>API 엔드포인트 URL 입니다.</td>
  </tr>
  <tr>
    <td>apiKey</td>
    <td>STRING</td>
    <td>리얼월드에서 발급한 API키 입니다.</td>
  </tr>
</table>
<br>

## Obfuscate API

### API 엔드포인트

```
https://api.realw.kr/obfuscate/v1
```

### 사용자 인증
API 호출시 `리얼월드`로 부터 발급받은 `API Key` 를 `X-API-Credential` 헤더로 전송해야 합니다.<br>
해당 헤더가 존재하지 않거나 올바르지 않은 `API Key` 가 전송되면 API 호출이 서버 대기열에서 삭제됩니다.

### 요청 빈도 제한
API 호출은 IP별 분당 100회로 제한됩니다.

### HTTP 반환 코드
- HTTP 4XX 반환 코드는 잘못된 요청에 사용됩니다. 문제는 호출자 측에 있습니다.
- HTTP 403 반환 코드는 WAF 제한(웹 응용 프로그램 방화벽)을 위반했을 때 사용됩니다.
- HTTP 429 반환 코드는 요청 속도 제한을 위반할 때 사용됩니다.
- HTTP 418 반환 코드는 코드를 받은 후 요청을 계속 보내기 위해 IP가 자동 금지되었을 때 사용됩니다.
- HTTP 5XX 반환 코드는 내부 오류에 사용됩니다. 문제는 API 서버측입니다.
<br>

### 난독화

난독화 호출시 해당 API 호출의 반환 결과에 난독화 된 데이터가 포함됩니다.<br>
난독화할 데이터가 클 경우 타임아웃이 발생할 수 있습니다.<br>
이 경우엔 아래의 비동기 방식을 이용할 수 있습니다.

```
POST /ob
```

- 매개변수
<table>
  <thead>
    <tr>
      <td>매개변수 명</td>
      <td>매개변수 타입</td>
      <td>필수값</td>
      <td>설명</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>fileName</td>
      <td>STRING</td>
      <td>예</td>
      <td>난독화할 파일이름</td>
    </tr>
    <tr>
      <td>script</td>
      <td>STRING</td>
      <td>예</td>
      <td>BASE64 로 인코딩된 LUA 소스코드</td>
    </tr>
    <tr>
      <td>options</td>
      <td>OBJECT</td>
      <td>아니요</td>
      <td>현재 사용하지 않음</td>
    </tr>
  </tbody>
</table>

### 난독화 (비동기)

난독화 호출시 비동기 방식으로 진행되며 추가적으로 아래의 /download API 를 호출하여 난독화 된 데이터를 다운받을 수 있습니다.

```
POST /new
```

- 매개변수
<table>
  <thead>
    <tr>
      <td>매개변수 명</td>
      <td>매개변수 타입</td>
      <td>필수값</td>
      <td>설명</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>fileName</td>
      <td>STRING</td>
      <td>예</td>
      <td>난독화할 파일이름</td>
    </tr>
    <tr>
      <td>script</td>
      <td>STRING</td>
      <td>예</td>
      <td>BASE64 로 인코딩된 LUA 소스코드</td>
    </tr>
    <tr>
      <td>options</td>
      <td>OBJECT</td>
      <td>아니요</td>
      <td>현재 사용하지 않음</td>
    </tr>
  </tbody>
</table>

### 난독화 진행 정보
```
GET /status/:id
```

- 매개변수
<table>
  <thead>
    <tr>
      <td>매개변수 명</td>
      <td>매개변수 타입</td>
      <td>필수값</td>
      <td>설명</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>id</td>
      <td>STRING</td>
      <td>예</td>
      <td>난독화 호출시 반환 받은 난독화 ID 입니다.</td>
    </tr>
  </tbody>
</table>

### 난독화 파일 다운로드
```
GET /download/:id?format=[json|file]
```

- 매개변수
<table>
  <thead>
    <tr>
      <td>매개변수 명</td>
      <td>매개변수 타입</td>
      <td>필수값</td>
      <td>설명</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>id</td>
      <td>STRING</td>
      <td>예</td>
      <td>난독화 호출시 반환 받은 난독화 ID 입니다.</td>
    </tr>
    <tr>
      <td>format</td>
      <td>STRING</td>
      <td>아니요</td>
      <td>출력할 포맷을 지정합니다. json, file (기본값: file)</td>
    </tr>
  </tbody>
</table>
<br>

## Pay API

리얼페이 페이지 참조: <a href="https://github.com/fivem-realw/rw-crypto-payments">rw-crypto-payments</a>

<br>

## Game API

리얼월드 2022 (FiveM) 오픈 후 이용가능 합니다.